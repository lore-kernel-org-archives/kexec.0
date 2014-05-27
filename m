Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-we0-f169.google.com ([74.125.82.169])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WpCGh-0004MJ-OL
 for kexec@lists.infradead.org; Tue, 27 May 2014 07:58:00 +0000
Received: by mail-we0-f169.google.com with SMTP id u56so9198659wes.28
 for <kexec@lists.infradead.org>; Tue, 27 May 2014 00:57:32 -0700 (PDT)
Received: from [192.168.1.80] (40.77.194.77.rev.sfr.net. [77.194.77.40])
 by mx.google.com with ESMTPSA id g10sm33045632wjs.33.2014.05.27.00.57.31
 for <kexec@lists.infradead.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Tue, 27 May 2014 00:57:31 -0700 (PDT)
Message-ID: <53844542.4060007@canonical.com>
Date: Tue, 27 May 2014 09:56:50 +0200
From: Louis Bouchard <louis.bouchard@canonical.com>
MIME-Version: 1.0
Subject: remote kernel crash dump for Debian and Ubuntu
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

Hello,

Some of you may want to give a test run to some enhancements I'm working on.

I am working on adding networked kernel dump functionality to the kernel crash
dump mechanism used on Debian and Ubuntu.

This is still in beta but has been working correctly for me.

You can find the details here on my blog :

http://caribou.kamikamamak.com/2014/05/20/remote-kernel-crash-dump-for-debian-and-ubuntu/

If there is some interest, I can post the modification as patches to the list
for review. Just let me know. Otherwise, you can view them at the following git
repository :

http://anonscm.debian.org/gitweb/?p=collab-maint/makedumpfile.git;a=shortlog;h=refs/heads/networked_kdump_beta1

TIA,

Kind regards,

...Louis

-- 
Louis Bouchard
Software engineer, Cloud & Sustaining eng.
Canonical Ltd
Ubuntu support: http://canonical.com/support

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
