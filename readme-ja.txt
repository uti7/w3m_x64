# vim: se ts=2 tw=72 ft=memo :

��w3m portable
																															2011-12-09
																									x64�ōč\�z	2017-08-14
�N��

	���̂����ꂩ�ōs��

	a) w3m.bat �����s
	b) launchW3m.exe �����s

	��a)�͈�u�R���\�[�����\�������Ab)�͕\������Ȃ�


�V�K�C���X�g�[���̏ꍇ

	�t�@�C���ɓK�؂ȃp�[�~�b�V������^����B
	���ɐݒ�t�@�C���◚���̂���t�H���_��cygwin���I�ɏ������݉\�łȂ�
	��΂Ȃ�Ȃ�(�ŋ߂�cygwin��FAT32�ɑ΂���chmod�Ȃǂ������Ȃ�)

	+ ���t�H���_(��)
	/cygdrive/c/cast/app/w3m_x64

	+ �ݒ�t�H���_
	/cygdrive/c/cast/app/w3m_x64/cyghome/.w3m/

	+ �p�[�~�b�V�����ݒ�

	# chmod -R 664 /cygdrive/c/cast/app/w3m_x64

	# find /cygdrive/c/cast/app/w3m_x64 -name \*.exe -print \
	#      -exec chmod ug+x {} \;

	# find /cygdrive/c/cast/app/w3m_x64 -type d -print \
	#      -exec chmod a+x {} \;

�e��ݒ��

+ �R���p�l�́u/ �ł���킳���f�B���N�g���v

	/cygdrive/c/cast/app/w3m_x64

+ �O���e�L�X�g�G�f�B�^

	�R���g���[���p�l���́u���p����G�f�B�^�v���ŉ��L�̂悤�ɐݒ�

	/cygdrive/C/cast/app/vim/gvim/gvim.exe "`cygpath -w %s`"


+ �O���u���E�U

	�R���g���[���p�l���́u�O���u���E�U�v���ŉ��L�̂悤�ɐݒ�

	launchW3m.exe "%s" /std
	
		�� launchW3m �� tools�t�H���_�Ƀ\�[�X(ahk�X�N���v�g)������

+ �O���摜�r���[�A

	.../.w3m/mailcap �܂���  /etc/mailcap �ňȉ��̂悤�ɂ���

	image/*; /cygdrive/c/PROGRA~1/IRFANV~1/i_view32.exe `cygpath -d %s`

+ �u�b�N�}�[�N�o�^

	/.w3m/bookmark.html �𒼐ڕҏW����
	(���K�̕��@�ł� perl ��K�v�Ƃ���AESC-a �Ȃǂ��g���Ȃ�)

	���u�b�N�}�[�N�y�[�W�� launchW3m.exe �������Ȃ��ŋN�������Ƃ�
		�ɂ������y�[�W�Ƃ��ĕ\�������

��(�[����ck�̏ꍇ�̂݁j
	Unicode�ɂ�����ꕔ�̕����́j�B���ȕ��̖��ɂ���ĕ\�����Y����ꍇ
	
	���p���ŕ`�悳���΃Y���Ȃ��̂����A���������Ȃ��ꍇ��
	.Xdefaults ��
	Ck*lineSpace: 8
	�̂悤�ɍs�Ԃ�傫������ƑS�p�\���̂܂܂ł��Y���Ȃ��Ȃ邩������Ȃ�

��(�[����mintty�̏ꍇ�̂݁j
	mintty.exe�������N�������bash�{w3m�̃E�B���h�E�i����mintty�̉�ʁj��
	�͕ʂ�mintty���g�̃R���\�[���E�B���h�E���\�������i�������cmd.exe��
	�E�B���h�E�Ɠ��l�̂��́B���͎͂󂯕t���Ȃ��j�B

	cygwin�{�̂�/bin/cygwin-console-helper.exe������΃R���\�[���͏o�͂���
	�Ȃ��Ȃ�i��exe�����t�H���_��bin�փR�s�[����j

�ȏ�
