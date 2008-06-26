Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBx2W-0003kb-7A
	for kexec@lists.infradead.org; Thu, 26 Jun 2008 19:21:52 +0000
Message-ID: <4863EB73.8070404@kernel.org>
Date: Thu, 26 Jun 2008 12:18:11 -0700
From: "H. Peter Anvin" <hpa@kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] Add /sys/firmware/memmap
References: <1214423826-12628-1-git-send-email-bwalle@suse.de>
	<1214423826-12628-2-git-send-email-bwalle@suse.de>
	<20080625224301.GE32344@redhat.com>
	<18531.20387.111875.576837@harpo.it.uu.se>
	<20080626104524.2d7ed1ab@halley.suse.de>
	<18531.23894.572847.322265@harpo.it.uu.se>
	<4863D930.2040300@kernel.org> <20080626181841.GE3878@redhat.com>
In-Reply-To: <20080626181841.GE3878@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, Bernhard Walle <bwalle@suse.de>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, yhlu.kernel@gmail.com

Vivek Goyal wrote:
>>>
>> Making this depend on KEXEC would be most unfortunate.  This is valuable  
>> information for finding all kinds of issues even in the absence of KEXEC.
>>
> 
> Agreed.
> 
>> I really don't see a point in making this configurable, except perhaps  
>> under CONFIG_EMBEDDED.
> 
> I think we should just not put this functionality under any CONFIG option.
> If we put it under CONFIG_EMBEDDED,  then even for using kexec, one
> shall have to turn CONFIG_EMBEDDED on which probably does not make much
> sense.
> 

Well, it should be *enabled* for !EMBEDDED.

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
