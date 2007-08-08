Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IIgyR-0000mP-2w
	for kexec@lists.infradead.org; Wed, 08 Aug 2007 04:33:01 -0400
Message-ID: <46B97FB2.1030502@fujitsu-siemens.com>
Date: Wed, 08 Aug 2007 10:32:50 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: PATCH/RFC: [kdump] fix APIC shutdown sequence
References: <46B73955.2080007@fujitsu-siemens.com>
	<20070807172911.cc626719.akpm@linux-foundation.org>
In-Reply-To: <20070807172911.cc626719.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Haren Myneni <hbabu@us.ibm.com>, Vivek Goyal <vgoyal@in.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hello Andrew,

thanks a lot for looking at this patch.

> Please feed the diff through scripts/checkpatch.pl.  It finds a lot of issues.

I should have read the latest version of SubmittingPatches :-(
I didn't expect you to pick up this patch so quickly, if I did
I'd have cleaned it more thoroughly. I apologize.

I expect this patch to go through a few more iterations in discussions
with Vivek and other people on this list.

> This is tricky code which you're adding.  Empirically-based stuff derived
> from observation and experimentation.  It is quite impossible for readers
> of this code to work out what the code is doing and why it is doing it
> purely by reading the C statements.

OK. I thought this might make the patch itself too long, that's why I put
it into the header.

Thanks, Martin

-- 
Martin Wilck
PRIMERGY System Software Engineer
FSC IP ESP DE6

Fujitsu Siemens Computers GmbH
Heinz-Nixdorf-Ring 1
33106 Paderborn
Germany

Tel:			++49 5251 8 15113
Fax:			++49 5251 8 20409
Email:			mailto:martin.wilck@fujitsu-siemens.com
Internet:		http://www.fujitsu-siemens.com
Company Details:	http://www.fujitsu-siemens.com/imprint.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
