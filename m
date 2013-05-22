Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uf4ry-0002oy-H2
 for kexec@lists.infradead.org; Wed, 22 May 2013 08:58:03 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: Different minor kexec cleanups
Date: Wed, 22 May 2013 10:57:32 +0200
Message-Id: <1369213056-77661-1-git-send-email-trenn@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: kexec@lists.infradead.org, yinghai@kernel.org, ebiederm@xmission.com, vgoyal@redhat.com

Hi,

after some holidays and catching up, I like to re-visit the:
Pass memory ranges via e820 tables to crash kernel
work.
These are some cleanup patches on code I stumbled over while looking at
this. It would be great if these can get applied, so that my local branch
is in sync with mainline. I then like to proceed with further cleanups and
finally get to the point where a clean, split up in small patches submission
to implement above is possible.

Thanks,

       Thomas



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
