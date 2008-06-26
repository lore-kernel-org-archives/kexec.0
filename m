Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBw8X-0005nu-JK
	for kexec@lists.infradead.org; Thu, 26 Jun 2008 18:24:01 +0000
Date: Thu, 26 Jun 2008 20:23:58 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH 1/2] Add /sys/firmware/memmap
Message-ID: <20080626202358.13066e6b@kopernikus.site>
In-Reply-To: <4863D930.2040300@kernel.org>
References: <1214423826-12628-1-git-send-email-bwalle@suse.de>
	<1214423826-12628-2-git-send-email-bwalle@suse.de>
	<20080625224301.GE32344@redhat.com>
	<18531.20387.111875.576837@harpo.it.uu.se>
	<20080626104524.2d7ed1ab@halley.suse.de>
	<18531.23894.572847.322265@harpo.it.uu.se>
	<4863D930.2040300@kernel.org>
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
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, yhlu.kernel@gmail.com, "H. Peter Anvin" <hpa@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

* "H. Peter Anvin" <hpa@kernel.org> [2008-06-26 11:00]:
> 
> Making this depend on KEXEC would be most unfortunate.  This is valuable 
> information for finding all kinds of issues even in the absence of KEXEC.
> 
> I really don't see a point in making this configurable, except perhaps 
> under CONFIG_EMBEDDED.

Now we have all opinions about how making that interface
configurable. Mikael, should an option under CONFIG_EMBEDDED be
acceptable for you?

Then I can repost the patch, Cc Greg KH and see if the sysfs structure
would be ok for him.



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
