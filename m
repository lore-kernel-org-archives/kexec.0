Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XuNFh-0001dW-Md
 for kexec@lists.infradead.org; Fri, 28 Nov 2014 15:14:34 +0000
Received: by mail-wg0-f54.google.com with SMTP id l2so9100355wgh.41
 for <kexec@lists.infradead.org>; Fri, 28 Nov 2014 07:14:11 -0800 (PST)
Received: from [192.168.1.10] (254.86.12.93.rev.sfr.net. [93.12.86.254])
 by mx.google.com with ESMTPSA id he3sm15388003wjc.15.2014.11.28.07.14.09
 for <kexec@lists.infradead.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Nov 2014 07:14:10 -0800 (PST)
Message-ID: <54789141.4060602@canonical.com>
Date: Fri, 28 Nov 2014 16:14:09 +0100
From: Louis Bouchard <louis.bouchard@canonical.com>
MIME-Version: 1.0
Subject: debian's kdump-tools migration to systemd
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello everyone,

I understand that this is Thanksgiving weekend so not many american eyes will
see this but I still want to bounce the idea somewhere before uploading this to
Debian.

I recently realized that the kernel dump mechanism (kdump-tools) on debian was
broken, partly because of systemd and also because of a change of format of the
dmesg log.  The later is fixed upstream but systemd is another issue.

Debian uses a sysVinit script called kdump-tools that setup kexec and prepare
things in case of a kernel panic. To make sure that a systemd enabled system
does not reach multi-user when a kernel panic triggers kexec to load the new
kernel, I am adding the following boot parameter :

  systemd.unit=kdump-tools.service

The systemd kdump-tools.service unit calls the kdump-tools script that copies
the content of /proc/vmcore to local storage and then reboots the server.

The rest of the execution remain identical. Systems that will not be running
systemd will remain unchanged.

I would be happy to take comments and suggestion but keep in mind that I have
limited time until debian's final freeze which is dec 5th so I will proceed with
my debian upload before that.

Kind regards,

...Louis

-- 
Louis Bouchard
Software engineer, Cloud & Sustaining eng.
Canonical Ltd
Ubuntu developer                       Debian Maintainer
GPG : 429D 7A3B DD05 B6F8 AF63  B9C4 8B3D 867C 823E 7A61

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
