Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W0DcM-0007nY-0A
 for kexec@lists.infradead.org; Mon, 06 Jan 2014 17:05:35 +0000
Date: Mon, 6 Jan 2014 12:05:10 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1761421528.25775303.1389027910680.JavaMail.root@redhat.com>
In-Reply-To: <1388862686-1832-1-git-send-email-dslutz@verizon.com>
References: <1388862686-1832-1-git-send-email-dslutz@verizon.com>
Subject: Re: [Crash-utility] [PATCH 0/4] Enable use of crash on xen 4.4.0
 vmcore
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, kexec@lists.infradead.org, xen-devel@lists.xen.org



----- Original Message -----
> With the addition on PVH code to xen 4.4, domain.is_hvm no longer
> exists.  This prevents crash from using a xen 4.4.0 vmcore.
> 
> Patch 1 "fixes" this.
> 
> Patch 2 is a minor fix in that outputing the offset in hex for
> domain_domain_flags is different.
> 
> Patch 3 is a bug fix to get all "domain_flags" set, not just the 1st
> one found.
> 
> Patch 4 is a quick way to add domain.guest_type support.

Hi Don,

The patch looks good to me.  But for the crash.changelog, can you show
what happens when you attempt to look at one of these PVH dumps without
your patches?

Thanks,
  Dave

> 
> Don Slutz (4):
>   Make domian.is_hvm optional
>   xen: Fix offset output to be decimal.
>   xen: set all domain_flags, not just the 1st.
>   Add basic domain.guest_type support.
> 
>  xen_hyper.c             | 32 ++++++++++++++++++++++++--------
>  xen_hyper_defs.h        |  1 +
>  xen_hyper_dump_tables.c |  4 +++-
>  3 files changed, 28 insertions(+), 9 deletions(-)
> 
> --
> 1.8.4
> 
> --
> Crash-utility mailing list
> Crash-utility@redhat.com
> https://www.redhat.com/mailman/listinfo/crash-utility
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
