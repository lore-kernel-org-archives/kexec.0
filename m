Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OjMsT-0001Vl-SC
	for kexec@lists.infradead.org; Thu, 12 Aug 2010 01:46:43 +0000
Message-ID: <4C635268.1030709@zytor.com>
Date: Wed, 11 Aug 2010 18:46:16 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: Question regardin intel64 arch and page table setup
References: <20100811194734.GD23317@hmsreliant.think-freely.org>
	<4C6301C2.5020808@zytor.com>
	<20100812010506.GB2258@localhost.localdomain>
In-Reply-To: <20100812010506.GB2258@localhost.localdomain>
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
To: Neil Horman <nhorman@redhat.com>
Cc: kexec@lists.infradead.org, ebiederm@xmission.com, Neil Horman <nhorman@tuxdriver.com>

On 08/11/2010 06:05 PM, Neil Horman wrote:
>
> Thanks for all the info, guys.  I hadn't considered that we couldn't access the
> 64 bit startup point for the bzImage.  I just figured we could jump to
> startup_32 + 0x200 in the bzImage header once I had the page table bit set up
> properly.
> 
> I hadn't considered the problems we might encounter with driver issues loading
> above 4gb and what have you, nor the starting of AP's.  
> 
> Regardless, I'll keep tinkering.  One more question.  When setting up the page
> table in the panic boot case, is it sufficient to setup an identity map for the
> pages in the reserved crashkernel range, or do we need to identity map the
> entire range of ram?
> 

Not clear to me.  Probably the former, but you might find problems.

Another issue: if you are planning to run SMP, the AP trampoline needs
low memory, too.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
