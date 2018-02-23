Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1epIuG-000496-GB
 for kexec@lists.infradead.org; Fri, 23 Feb 2018 19:21:22 +0000
Date: Fri, 23 Feb 2018 20:21:06 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH] kexec: do KEXEC_FILE_LOAD and fallback to KEXEC_LOAD if
 not supported.
Message-ID: <20180223202106.4e39ff8c@kitsune.suse.cz>
In-Reply-To: <20180222232043.GC693@localhost.localdomain>
References: <20180222222442.9422-1-msuchanek@suse.de>
 <20180222232043.GC693@localhost.localdomain>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: Tony Jones <tonyj@suse.com>, horms@verge.net.au, kexec@lists.infradead.org, Petr Tesarik <ptesarik@suse.cz>

On Fri, 23 Feb 2018 07:20:43 +0800
Baoquan He <bhe@redhat.com> wrote:

> Hi Michal,
> 
> On 02/22/18 at 11:24pm, Michal Suchanek wrote:
> > The new KEXEC_FILE_LOAD is preferred in the case the platform
> > supports it because it allows kexec in locked down secure boot mode.
> > 
> > However, some platforms do not support it so fall back to the old
> > syscall there.  
> 
> I didn't read code change, just from patch log, I tend to not agree.
> There are two options KEXEC_FILE_LOAD and KEXEC_LOAD, some platforms
> do not support, why does some platforms not choose KEXEC_LOAD, the
> working one? 

Because nobody wrote the support. If you volunteer to write support for
KEXEC_FILE_LOAD for every platform Linux supports and add the respective
syscall numbers to kexec so it knows how to execute the syscall on
every platform I will consider it alternative fix. 

Some people will argue that not everyone applies the patches
to support KEXEC_FILE_LOAD in the kernel overnight, though.

> Why bother to make change in code? 

Because it is unusable as is. Just calling kexec fails with locked-down
secure boot. Calling kexec -s fails on almost every platform except x86.

> I believe there's
> returned message telling if KEXEC_FILE_LOAD works or not.

That is not a solution. A way to call kexec that actually works is
needed. This patch removes the need to use the undocumented -s option
to get the new superior syscall you seem to prefer. It will just do the
right thing in most cases. It allows the user to select either syscall
explicitly as well. I do not see the problem with that.

Thanks

Michal

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
