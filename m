Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L0XBh-0001vI-69
	for kexec@lists.infradead.org; Thu, 13 Nov 2008 08:04:25 +0000
Date: Thu, 13 Nov 2008 09:04:21 +0100
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Always use 64 bit addresses for the firmware memory map
Message-ID: <20081113090421.763f7df3@hale.suse.de>
In-Reply-To: <491B6855.1080609@kernel.org>
References: <1226519089-21647-1-git-send-email-bwalle@suse.de>
	<491B358D.2040304@kernel.org>
	<20081112221106.5d9d7801@kopernikus.site>
	<491B6855.1080609@kernel.org>
Mime-Version: 1.0
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
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

* H. Peter Anvin [2008-11-12 15:35]:
>
> Bernhard Walle wrote:
> > * H. Peter Anvin [2008-11-12 11:59]:
> >> I want to make sure, though, that we don't just end up pushing the
> >> truncation further down in the code.
> > 
> > Well, I think that interface should export the BIOS memmap as provided.
> > Since E820 does provide 64 bit addresses, that should get exported.
> > 
> > It should even possible to kexec a PAE kernel from a non PAE kernel ...
> > I didn't test, but it could work. But only if the E820 map is correctly
> > written in the zero page, which is only the case if we get it correctly.
> 
> That's fine, but we do have to check that we don't truncate elsewhere.

What do you mean? That my patch doesn't fix all problems that might
exist but are not yet fixed or that my patch introduces new problems?

Well, for example in the resource reservation code [e820.c,
e820_reserve_resource()] that is handled at line 1285:

		if (end != (resource_size_t)end) {
			res++;
			continue;
		}

My patch only changes the firmware interface, not the architecture
specific code. However, I cannot guarantee that it doesn't break
something, but what action do you expect from me that the patch is
taken?


Regards,
Bernhard


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
