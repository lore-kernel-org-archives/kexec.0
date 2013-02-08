Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U3uzd-0003zc-0E
 for kexec@lists.infradead.org; Fri, 08 Feb 2013 20:56:21 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 0/3] Cleanup kdump memmap= passing and e820 usage
Date: Fri, 08 Feb 2013 21:56:08 +0100
Message-ID: <7019180.H6x7rnEQXy@skinner.arch.suse.de>
In-Reply-To: <87txpmv9hx.fsf@xmission.com>
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
 <1855338.FfngI2qLCK@skinner.arch.suse.de> <87txpmv9hx.fsf@xmission.com>
MIME-Version: 1.0
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, yinghai@kernel.org, vgoyal@redhat.com

On Friday, February 08, 2013 12:25:14 PM Eric W. Biederman wrote:
> Thomas Renninger <trenn@suse.de> writes:
...
> > In a kernel which has the patch/functionality backported I would do
> > 
> > it like this then:
> >   - If the special kdump e820 type shows up, all memmap options from
> >   
> >     memmap=exactmap on are ignored and the kexec-tools passed
> >     e820 table is used just as it is.
> >     -> This would still allow e820 modifcations through memmap=
> >     if passed manually for debugging, they just have to show up before
> >     the kexec-tools generated ones. Anyway, I will also send a patch
> >     how I think this can be backported and still work with old and new
> >     kexec-tools versions.
> 
> Way over complicated.  kexec-tools can just stop passing the memmap=
> options entirely for every kernel.
Ah yes, sure. This is really nice.
I hope things work out like that, I'll report back next week.

Have a nice week-end,

  Thomas

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
