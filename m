Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Txfee-0004Hk-Lj
 for kexec@lists.infradead.org; Tue, 22 Jan 2013 15:20:53 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 0/2] Only parse exactmap once, introduce memmap=resetusablemap
Date: Tue, 22 Jan 2013 16:20:47 +0100
Message-Id: <1358868049-19884-1-git-send-email-trenn@suse.de>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: hpa@zytor.com
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, yinghai@kernel.org, vgoyal@redhat.com

this is a clean resend of Yinghai's memmap= extensions.
They were discussed on lkml in a thread with subject:
[PATCH] x86 e820: only void usable memory areas in memmap=exactmap case

The patches are based on origin/x86/mm2 where another memmap= 
enhancement from Yinghai is already queued.

Would be great if these can be queued there as well.

Thanks,

   Thomas


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
