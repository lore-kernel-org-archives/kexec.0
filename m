Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dCazF-0001Cs-RQ
 for kexec@lists.infradead.org; Mon, 22 May 2017 00:14:16 +0000
Received: by mail-pf0-x235.google.com with SMTP id m17so64979616pfg.3
 for <kexec@lists.infradead.org>; Sun, 21 May 2017 17:13:52 -0700 (PDT)
Date: Mon, 22 May 2017 09:18:07 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v7 01/10] kexec: exntend the semantics of
 kexec_iomem_for_each_line
Message-ID: <20170522001806.GA6544@linaro.org>
References: <20170517055150.12601-1-takahiro.akashi@linaro.org>
 <20170517055150.12601-2-takahiro.akashi@linaro.org>
 <1495064224.19471.13.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1495064224.19471.13.camel@infradead.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: geoff@infradead.org, panand@redhat.com, horms@verge.net.au, kexec@lists.infradead.org

On Wed, May 17, 2017 at 04:37:04PM -0700, David Woodhouse wrote:
> On Wed, 2017-05-17 at 14:51 +0900, AKASHI Takahiro wrote:
> > The current kexec_iomem_for_each_line() counts up all the lines for which
> > a callback function returns zero(0) or positive, and otherwise it stops
> > further scanning.
> > This behavior is incovenient in some cases. For instance, on arm64, we want
> > to count up "System RAM" entries, but need to skip "reserved" entries.
> 
> s/exntend/extend/ and s/incovenient/inconvenient/ but other than that,
> all ten patches
> Tested-by: David Woodhouse <dwmw@amazon.co.uk>

Thanks a lot!

> Simon, any chance of a 2.0.15 release once these are merged please?

For your convenience, you can also find my patch with fixes above:
http://git.linaro.org/people/takahiro.akashi/kexec-tools.git

> Thanks for your continued effort on this, Akashi-san. Congratulations
> on finally getting the support merged into 4.12!
> 
> I've backported the final set of patches to 4.9 too. That's where I'm
> going to be using it for the moment. In case it's useful to anyone
> else, it's here:
> http://git.infradead.org/users/dwmw2/arm64-kdump-4.9.git

Great.
Just FYI, we, linaro, will also backport kdump to our lsk v4.4 and v4.9.

Thanks,
-Takahiro AKASHI

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
