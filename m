Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WDzlk-0005i6-35
 for kexec@lists.infradead.org; Thu, 13 Feb 2014 17:08:13 +0000
Date: Thu, 13 Feb 2014 12:07:47 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Tool for creating full vmcore
Message-ID: <20140213170747.GJ30844@redhat.com>
References: <52FBD7C3.4060304@acm.org> <20140212214257.GF16470@redhat.com>
 <CADq4U7+K-Zi2Ckb-mfDWFf50Oq7hbTWR6H92=Jx=STqWSJu89g@mail.gmail.com>
 <20140213135153.GB30844@redhat.com>
 <20140213135229.GC30844@redhat.com> <52FCF69C.2080108@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52FCF69C.2080108@acm.org>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Corey Minyard <minyard@acm.org>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, Dave Anderson <anderson@redhat.com>

On Thu, Feb 13, 2014 at 10:45:16AM -0600, Corey Minyard wrote:

[..]
> >>
> >> I guess if code is small enough, then it might be useful to 
> >> keep it in a direcotry say kexec-tools/vmcore-kcore. But if it turns
> >> out to be big, it might be better to maintain it as a separate project
> >> (like makedumpfile).
> 
> Yeah, it's a little big, but not huge.  Most of the code is the elf
> part, which is in it's own file and could be a separate library.  I'm
> fine either way.  It will get bigger as new arch-specific code is added.

This does sound like significant code when other arch support is added.
I am beginning to think if it better to manage it as a separate project
in separate git tree.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
