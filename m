Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.syneticon.net ([213.239.212.131] helo=mail2.syneticon.net)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JQLZ1-0004s2-8n
	for kexec@lists.infradead.org; Sat, 16 Feb 2008 11:50:40 +0000
Message-ID: <47B6CE01.60701@wpkg.org>
Date: Sat, 16 Feb 2008 12:50:25 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
MIME-Version: 1.0
Subject: [PATCH] kexec tools mipsel port
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Kexec Mailing List <kexec@lists.infradead.org>, Horms <horms@verge.net.au>, francesco.chiechi@colibre.it

>> We developed a patch to port kexec-tools to mips arch and included
>> support for command line passing through elf boot notes.  We did it
>> for a customer of ours on a specific platform derived from toshiba
>> tx4938 (so we think it should work at least for tx4938 evaluation
>> board also).  We would like to contribute it in case somebody else
>> needs it or wants to improve it.  This patch works for us but the
>> assembler part in particular, should be considered as a starting point
>> because my assembly knowledge is not too deep.
>
> thanks for the patch. Sending them to this list is indeed the right
> thing to do. You can also CC me (who makes the commits) to be sure
> to get my attention.

Hi,

There was a thread about kexec-tools mipsel port on Kexec Mailing List 
in June 2007.

What's the current state of this patch?

Is it working, will be merged, will not be merged?


-- 
Tomasz Chmielewski
http://wpkg.org


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
