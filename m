Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gw.goop.org ([64.81.55.164] helo=mail.goop.org)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L0Q89-0003iF-Lv
	for kexec@lists.infradead.org; Thu, 13 Nov 2008 00:32:18 +0000
Message-ID: <491B758E.5090902@goop.org>
Date: Wed, 12 Nov 2008 16:32:14 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Always use 64 bit addresses for the firmware memory map
References: <1226519089-21647-1-git-send-email-bwalle@suse.de>
	<491B398C.9090207@goop.org> <491B681B.6040405@kernel.org>
In-Reply-To: <491B681B.6040405@kernel.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@kernel.org>
Cc: Bernhard Walle <bwalle@suse.de>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

H. Peter Anvin wrote:
> Jeremy Fitzhardinge wrote:
>   
>> resource_size_t should always be 64-bit on PAE now.
>>
>>     
>
> Yes, but this would affect non-PAE kernels too.
>   

Yeah, I overlooked the comment about non-PAE.  Should we just make 
resource_size_t 64 bits all the time?  Or ignore inaccessible resources?

    J

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
