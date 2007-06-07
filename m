Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-blu.frontbridge.com ([65.55.251.16]
	helo=outbound3-blu-R.bigfish.com)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HwNB9-0005DX-Na
	for kexec@lists.infradead.org; Thu, 07 Jun 2007 14:57:54 -0400
Message-ID: <466854E5.6080506@am.sony.com>
Date: Thu, 07 Jun 2007 11:56:37 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: Re: [RFC] kexec: Build 32 bit kexec for ppc64
References: <46683C9F.1020903@am.sony.com>
	<1181237465.2785.85.camel@pmac.infradead.org>
In-Reply-To: <1181237465.2785.85.camel@pmac.infradead.org>
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
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org

David Woodhouse wrote:
> On Thu, 2007-06-07 at 10:13 -0700, Geoff Levand wrote:
>> 64 bit: OK
>> 32 bit: purgatory build fails 
> 
> Hm, what'd you do to it? Fedora is shipping this (ugly as it is) and
> it's working. Well, it would if the PS3 kernel would :)

You original is against an old version of kexec-tools, and I guess you
don't build it cross with the Cell-SDK toolchain.  Those are the things
that need fixing.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
