Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TvRHu-0006vD-1I
 for kexec@lists.infradead.org; Wed, 16 Jan 2013 11:36:10 +0000
Received: by mail-wi0-f176.google.com with SMTP id hm6so3339008wib.3
 for <kexec@lists.infradead.org>; Wed, 16 Jan 2013 03:36:07 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 16 Jan 2013 17:06:07 +0530
Message-ID: <CAJXQGfLPw1o_n9o-=2Pde4x4zjNrh8kgiVGTocqyjMwYcxtpSQ@mail.gmail.com>
Subject: KEXEC with ramdisk - Base address: 809de380 is not page aligned
From: Naresh Bhat <nareshgbhat@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Daniel Mack <zonque@gmail.com>
Cc: Naresh Bhat <nareshgbhat@gmail.com>, kexec@lists.infradead.org

Hi,

I am trying to use the --initrd or --ramdisk options but end-up with
the "Base address: 809de380 is not page aligned" error. I am executing
the following command.

root@arm-cortex-a15:~# kexec -l zImage --initrd=ramdisk.cpio.gz
--command-line="root=/dev/ram rw ip=dhcp console=ttyAMA0,38400n8
init=/bin/bash"
Base address: 809de380 is not page aligned
root@arm-cortex-a15:~#
root@arm-cortex-a15:~# kexec -l zImage --ramdisk=ramdisk.cpio.gz
--command-line="root=/dev/ram rw ip=dhcp console=ttyAMA0,38400n8
init=/bin/bash"
Base address: 809de380 is not page aligned
root@arm-cortex-a15:~#

I have also tried with the ramdisk.img, endup with same error as
above.  I am using latest kexec-tools and kernel.org kernel on
Versatile express Cortex-A15 V2P target.   I will appreciate your
inputs/thoughts w.r.t. kexec-tools.

--Thanks and Regards
Naresh Bhat

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
