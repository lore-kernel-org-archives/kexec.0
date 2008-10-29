Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga01.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kv1fL-0006Tb-Sf
	for kexec@lists.infradead.org; Wed, 29 Oct 2008 03:24:20 +0000
Subject: [PATCH 0/2] kexec jump/hibernation support for kexec-tools
From: Huang Ying <ying.huang@intel.com>
Date: Wed, 29 Oct 2008 11:24:13 +0800
Message-Id: <1225250653.24095.39.camel@yhuang-dev.sh.intel.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1631696032=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>


--===============1631696032==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-M842gTQQB9J5aiSifwgN"


--=-M842gTQQB9J5aiSifwgN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This patchset add kexec jump/hibernation support to kexec
tools. Together with the kexec jump/hibernation features in Linux
kernel (which is merged into mainstream from 2.6.27 on) can be used
for following:

- A simple hibernation implementation without ACPI support. You can
  kexec a hibernating kernel, save the memory image of original system
  and shutdown the system. When resuming, you restore the memory image
  of original system via ordinary kexec load then jump back.

- Kernel/system debug through making system snapshot. You can make
  system snapshot with kexec/kdump, jump back, do some thing and make
  another system snapshot.

- Cooperative multi-kernel/system. With kexec jump, you can switch
  between several kernels/systems quickly without boot process except
  the first time. This appears like swap a whole kernel/system out/in.

- A general method to call program in physical mode (paging turning
  off). This can be used to invoke BIOS code under Linux.


The following additional kernel/tools may be needed for kexec
jump/hibernation:

- Linux kernel from 2.6.27 on.

- makedumpfile with patches are used as memory image saving tool, it
  can exclude free pages from original kernel memory image file. The
  patches and the precompiled makedumpfile can be download from the
  following URL:
       source: http://khibernation.sourceforge.net/download/release_v10/mak=
edumpfile/makedumpfile-src_cvs_kh10.tar.bz2
       patches: http://khibernation.sourceforge.net/download/release_v10/ma=
kedumpfile/makedumpfile-patches_cvs_kh10.tar.bz2
       binary: http://khibernation.sourceforge.net/download/release_v10/mak=
edumpfile/makedumpfile_cvs_kh10

- An initramfs image can be used as the root file system of kexeced
  kernel. An initramfs image built with "BuildRoot" can be downloaded
  from the following URL:
       initramfs image: http://khibernation.sourceforge.net/download/releas=
e_v10/initramfs/rootfs_cvs_kh10.gz
  All user space tools above are included in the initramfs image.


Usage example of simple hibernation:

1. Compile and install Linux kernel (newer than 2.6.27) with following
options selected:

CONFIG_X86_32=3Dy
CONFIG_RELOCATABLE=3Dy
CONFIG_KEXEC=3Dy
CONFIG_CRASH_DUMP=3Dy
CONFIG_PM=3Dy
CONFIG_HIBERNATION=3Dy
CONFIG_KEXEC_JUMP=3Dy

2. Build an initramfs image contains kexec-tool and makedumpfile, or
   download the pre-built initramfs image, called rootfs.gz in
   following text.

3. Prepare a partition to save memory image of original kernel, called
   hibernating partition in following text.

4. Boot kernel compiled in step 1 (kernel A).

5. In the kernel A, load kernel compiled in step 1 (kernel B) with
   /sbin/kexec. The shell command line can be as follow:

   /sbin/kexec --load-preserve-context /boot/bzImage --mem-max=3D0xffffff -=
-initrd=3Drootfs.gz

6. Boot the kernel B with following shell command line:

   /sbin/kexec -e

7. The kernel B will boot as normal kexec. In kernel B the memory
   image of kernel A can be saved into hibernating partition as
   follow:

   jump_back_entry=3D`cat /proc/cmdline | tr ' ' '\n' | grep kexec_jump_bac=
k_entry | cut -d '=3D'`
   echo $jump_back_entry > kexec_jump_back_entry
   cp /proc/vmcore dump.elf

   Then you can shutdown the machine as normal.

8. Boot kernel compiled in step 1 (kernel C). Use the rootfs.gz as
   root file system.

9. In kernel C, load the memory image of kernel A as follow:

   /sbin/kexec -l --args-none --entry=3D`cat kexec_jump_back_entry` dump.el=
f

10. Jump back to the kernel A as follow:

   /sbin/kexec -e

   Then, kernel A is resumed.


Now, only the i386 architecture is supported. The patchset is based on
the latest kexec-tools git tree, and has been tested on IBM T42 with
ACPI on and off.


Signed-off-by: Huang Ying <ying.huang@intel.com>


--=-M842gTQQB9J5aiSifwgN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkH11gACgkQKhFGF+eHlpgjrACfSzS8WoujFo0aSPbb3HYswE/2
ghYAoIq1RysvybQQBevg6bt/0PTUQfIO
=XyjX
-----END PGP SIGNATURE-----

--=-M842gTQQB9J5aiSifwgN--



--===============1631696032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1631696032==--


