Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JQbZy-0005vU-Ez
	for kexec@lists.infradead.org; Sun, 17 Feb 2008 04:56:42 +0000
Date: Sun, 17 Feb 2008 13:56:36 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec tools mipsel port
Message-ID: <20080217045634.GA4098@verge.net.au>
References: <47B6CE01.60701@wpkg.org> <20080216163357.GA32373@verge.net.au>
	<47B74826.8090707@wpkg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47B74826.8090707@wpkg.org>
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
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: francesco.chiechi@colibre.it, Kexec Mailing List <kexec@lists.infradead.org>

On Sat, Feb 16, 2008 at 09:31:34PM +0100, Tomasz Chmielewski wrote:
> Simon Horman schrieb:
>> On Sat, Feb 16, 2008 at 12:50:25PM +0100, Tomasz Chmielewski wrote:
>>>>> We developed a patch to port kexec-tools to mips arch and included
>>>>> support for command line passing through elf boot notes.  We did it
>
> (...)
>
>>> There was a thread about kexec-tools mipsel port on Kexec Mailing 
>>> List  in June 2007.
>>>
>>> What's the current state of this patch?
>>>
>>> Is it working, will be merged, will not be merged?
>>
>> Its still very much in the state of needing someone to
>> nurse it into a merge.
>
> Funny thing is, kernel supports kexec, but there is no userland support  
> for it (well, unless you patch kexec-tools with the patches you found  
> somewhere on the internet).
>
> I'll try to see if the old patches posted to this list work for me.

I'm quite happy to accept patches to add mipsel to kexec-tools
(for the kexec-tools-testing tree that I maintain) and include
it in the next release.

The problem is that I'm not sure what state the patches are in.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
