Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fYCCt-0006GV-VS
 for kexec@lists.infradead.org; Wed, 27 Jun 2018 15:18:10 +0000
Received: by mail-ot0-x230.google.com with SMTP id v24-v6so2584049otk.13
 for <kexec@lists.infradead.org>; Wed, 27 Jun 2018 08:17:57 -0700 (PDT)
MIME-Version: 1.0
From: Chris Murphy <lists@colorremedies.com>
Date: Wed, 27 Jun 2018 09:17:55 -0600
Message-ID: <CAJCQCtQEom-_J9Gji-WRgj3V_2zjUWXxUhPkc+jCj+N2KP3rJw@mail.gmail.com>
Subject: kdump on VFAT?
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi,

Buried in this Fedora thread on the BootLoaderSpec, is the discussion on the
technical merit (or not) of using VFAT for /boot which is currently
where kdump drops the vmcore dumpfiles. So I'm wondering if
there are any developer concerns about dumps going to VFAT and also if
a viable work around is putting crash dumps in /var instead?

For reference, BootLoaderSpec in effect requires VFAT for $BOOT which
would contain bootloader configuration, kernel, initramfs, and would
be mounted at /boot

Fedora thread to make BootLoaderSpec default in Fedora 29 (note that
really this feature only implements BootLoaderSpec file format for
bootloader configuration; not the full spec that includes the VFAT
requirement - that's still under discussion).
https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/message/CTKJBECHWEVF5IN6FO5TV7SIYWIMKYRT/


BootLoaderSpec
https://www.freedesktop.org/wiki/Specifications/BootLoaderSpec/
https://github.com/systemd/systemd/blob/master/doc/BOOT_LOADER_SPECIFICATION.md



-- 
Chris Murphy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
