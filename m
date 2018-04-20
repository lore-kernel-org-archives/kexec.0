Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f9bVb-0004Y8-I6
 for kexec@lists.infradead.org; Fri, 20 Apr 2018 19:15:49 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: RFC Xen signature verification for kexec
Message-ID: <81714431-9776-7247-86db-c035fa3d2ce6@oracle.com>
Date: Fri, 20 Apr 2018 14:12:59 -0500
MIME-Version: 1.0
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: xen-devel@lists.xen.org, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

In reading this and providing feedback, I'm hoping to obtain
community consensus on the following questions:
- Is there interest in this?
- Which approach is favored?
- Are there other approaches/efforts?
- Other concerns/feedback?

Executive Summary
Xen currently lacks signature verification infrastructure which makes
it vulnerable to exploit, even with secure boot mode, such as UEFI.
This proposal outlines a high-level approach to support signature
verification for kexec in Xen.

Option 1: Port Linux signature verification into Xen
Option 2: Enable signature verification in Xen utilizing libgcrypt

Overview
In UEFI secure boot mode, a "root of trust" is established. Typically,
UEFI secure boot verifies a boot loader, e.g. GRUB2, first. Then the
bootloader verifies Xen using the UEFI shim protocol and Xen verifies
the dom0 [Linux] kernel using shim protocol too.  Xen utilizes the
UEFI shim protocol at boot to verify the dom0 kernel.[1]

Thus UEFI can be used to boot into a "trusted" Xen and dom0 kernel.
However, this "trusted" environment is vulnerable to exploit as a dom0
user space application can be utilized to kexec a second, untrusted
kernel.

In the Xen environment, the kexec/kdump solution involves user space
utilities (eg. kexec-tools and makedumpfile), hypervisor support (eg.
xen/common/kexec.c) and post-mortem analysis tools (eg. crash).

Typically, in the Xen environment, the kexec of a second kernel (plus
initrd) is requested by /sbin/kexec binary *directly* invoking the Xen
kexec hypercall (which bypasses dom0) with a data structure pointing
to loadable segments.  Xen then places these segments into memory.
This second kernel is not verified, and the system can be rebooted
into an untrusted kernel.

As it stands today, the Xen hypervisor has no mechanism for signature
verification, and thus can not prevent this exploit.

NOTE: A solution for signature verification in Xen would perhaps also
enable a solution for LivePatch signature checking.


#####
Two options for signature verification in Xen

This proposal outlines two options under consideration for enhancing
Xen to support signature verification of kexec loaded images. The
first option is essentially to mirror Linux signature verification
code into Xen. The second option utilizes components from sources
other than Linux (for example, libgcrypt rather than linux/crypto).

NOTE: An option to utilize dom0 kernel signature verification does not
prevent the exploit as user space can invoke the hypercall directly,
bypassing dom0.

#####
Option 1: Port Linux signature verification into Xen

This option essentially is porting the Linux kexec_file_load()
system call as a new Xen kexec hypercall operation, for example,
KEXEC_CMD_kexec_file_load.

The license of Linux and Xen allow for Xen to take files from Linux
and incorporate into Xen. So in general most of this could be lifted
from Linux and dropped into Xen with the new hypercall op providing a
needed wrapper.

Pros:
- Most of the code already exists in Linux

Cons:
- This could potentially be taking tens of files from Linux and
   placing into Xen (linux/crypto has 115 source files). This
   would be a problematic management scenario going forward with
   uptaking changes in Linux and merging into Xen, and vice versa.

Changes to kexec-tools:
- Changes primarily to do_kexec_file_load():
   - if xen_present()...
     - Read entire file contents into buffer
     - Invoke new hypercall op

Changes to Xen:
- Import linux/crypto, linux/include/crypto, and
   linux/arch/x86/crypto <-- RSA, SHA, PKCS, etc
- Import linux/crypto/asymmetric_keys <-- PE handling
- Import linux/certs  <-- has system_keyring
- Import security/keys <-- key management
- Import various accompanying CONFIG settings
- Implement new hypercall operation,
   patterning after Linux' kexec_file_load(). One
   difference would be that rather than passing
   file handles, Xen would need to be passed pointers
   to the buffer(s) containing the image(s), as Xen
   can not read a file (for second kernel and the
   initrd) from Linux. Xen can access the buffer(s)
   via copy_from_user().

#####
Option 2: Enable signature verification in Xen utilizing libgcrypt

This option is similar to Option 1, but utilizes libgcrypt
crytpo library rather than linux/crypto files.

Pros:
- Libgcrypt is LGPLv2.1+ license.
- Eliminates problematic scenario of tracking changes to
   linux/crypto sources in Xen, and vice versa in Linux.

Cons:
- Introduces a dependency on libgcrypt
- Still relying on lifting many Linux kernel sources for PE file
   handling, certificate handling, etc. However, an alternative
   source for PE file handling is shim.

Changes to kexec-tools:
- Exactly same as Option 1 Xen version above

Changes to Xen:
- Changes are essentially same as Option 1 Xen above, but
   replacing linux/crypto with libgcrypt. This also involves
   changes around the API differences between linux/crypto
   and libgcrypt.

References:
[1] "XPDDS17: EFI Secure Boot, Shim and Xen: Current Status and
     Developments - Daniel Kiper - Oracle"
 
https://www.slideshare.net/xen_com_mgr/xppds17-efi-secure-boot-shim-and-xen-current-status-and-developments-daniel-kiper-oracle

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
