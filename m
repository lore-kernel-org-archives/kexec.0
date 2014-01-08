Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W0zZG-0000q5-LG
 for kexec@lists.infradead.org; Wed, 08 Jan 2014 20:17:35 +0000
Date: Wed, 8 Jan 2014 21:16:59 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH 0/4] Enable use of crash on xen 4.4.0 vmcore
Message-ID: <20140108201659.GB3633@olila.local.net-space.pl>
References: <1388862686-1832-1-git-send-email-dslutz@verizon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1388862686-1832-1-git-send-email-dslutz@verizon.com>
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
To: Don Slutz <dslutz@verizon.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, xen-devel@lists.xen.org, kexec@lists.infradead.org, crash-utility@redhat.com

On Sat, Jan 04, 2014 at 02:11:22PM -0500, Don Slutz wrote:
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

Sorry for late reply but I was on holiday.

Nice work. Thanks. I have done some tests with old
and new Xen versions and it looks that it works
without any issue.

Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
Tested-by: Daniel Kiper <daniel.kiper@oracle.com>

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
