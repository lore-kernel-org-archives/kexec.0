Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Y8JCD-0001DW-Go
 for kexec@lists.infradead.org; Tue, 06 Jan 2015 01:44:34 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t061iCIJ013016
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <kexec@lists.infradead.org>; Mon, 5 Jan 2015 20:44:12 -0500
Date: Tue, 6 Jan 2015 09:44:05 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] kexec, remove panic_on_warn kernel parameter from kdump
 situations
Message-ID: <20150106014405.GA2113@darkstar.redhat.com>
References: <1419951471-19765-1-git-send-email-prarit@redhat.com>
 <20150102125423.GA18785@redhat.com> <54A69808.4010401@redhat.com>
 <20150102131709.GB18785@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150102131709.GB18785@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Prarit Bhargava <prarit@redhat.com>, kexec@lists.infradead.org, WANG Chao <chaowang@redhat.com>

On 01/02/15 at 08:17am, Vivek Goyal wrote:
> On Fri, Jan 02, 2015 at 08:07:20AM -0500, Prarit Bhargava wrote:
> > 
> > 
> > On 01/02/2015 07:54 AM, Vivek Goyal wrote:
> > > On Tue, Dec 30, 2014 at 09:57:51AM -0500, Prarit Bhargava wrote:
> > >> panic_on_warn kernel parameter will cause the kernel to panic when a
> > >> WARN() is hit in the kernel.  This is not a good situation for the kdump
> > >> kernel because then it would be possible for the kdump kernel to panic in
> > >> a non-fatal WARN().
> > >>
> > >> This patch removes panic_on_warn as a kernel parameter for the kdump
> > >> kernel.
> > >>
> > > 
> > > I think modifying kexec-tools is not best place for this. It probably is better to take care of this in distribution specific scripts.
> > > 
> > > In the past we have learnt that it is best that kexec-tools does least
> > > amount of manipulation with command line.
> > 
> > Well .. here's the question to think about: what does adding panic_on_warn to
> > the kdump kernel get you?  AFAICT, nothing.
> 
> Let us consider a hypothetical situation. What if we have some buggy code
> which will corrupt file system in certain situation and we detect that
> situation and throw a warning. 
> 
> In that case as a work around specifying panic_on_warn in kdump kernel
> will make sense as we don't want to make further progress if we hit
> the warning as it has potential to corrupt fs.
> 
> Again this is hypothetical but it can happen. So panic_on_warn might
> still be useful in kdump kernel for some corner debugging cases.
> 
> That's why I think we should do it in distribution specific scripts
> and that too only if user did not specify panic_on_warn for second
> kernel explicitly.

Thinking of user who use upstream kexec-tools instead of distribution toolset,
In case kexec --reuse-cmdline, it will copy /proc/cmdline, but user will have
no way to remove part of them.

I do want to insist on removing 'panic_on_warn' in upstream kexec-tools, but
we should give user an option to remove it. Something like:

kexec --reuse-cmdline --remove-params="panic_on_warn" will be good.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
