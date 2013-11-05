Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ie0-x230.google.com ([2607:f8b0:4001:c03::230])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VdUeK-0002jS-Kj
 for kexec@lists.infradead.org; Tue, 05 Nov 2013 00:37:41 +0000
Received: by mail-ie0-f176.google.com with SMTP id u16so13541917iet.21
 for <kexec@lists.infradead.org>; Mon, 04 Nov 2013 16:37:15 -0800 (PST)
Message-ID: <52783DB9.7050000@gmail.com>
Date: Mon, 04 Nov 2013 16:37:13 -0800
From: Jay Lan <jay.zen.lan@gmail.com>
MIME-Version: 1.0
Subject: building makedumpfile 1.5.4 for sles11sp2?
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi,

It seems the makedumpfile.spec was written for fedora. It
probably would work in rhel, but I was not able to build it
in an sles11sp2 build environment...

The spec file complained it needed elfutils-devel-static.
I tried to install elfutils-devel-static-0.156-5.fc19.x86_64.rpm
to an sles11sp2, it then complained more failed dependency.

How do I build makedumpfile with community tarball in an
sles11sp2 environment? Thanks in advance!

Jay


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
