Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bmWDO-0006xl-CI
 for kexec@lists.infradead.org; Wed, 21 Sep 2016 01:20:46 +0000
Date: Wed, 21 Sep 2016 09:20:22 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v10 RESEND 0/3] Documentation: Add description of enable
 multi-cpus support for kdump
Message-ID: <20160921012022.GA12091@x1.redhat.com>
References: <1474264789-11705-1-git-send-email-bhe@redhat.com>
 <20160920180346.595fd720@lwn.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160920180346.595fd720@lwn.net>
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
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, kexec@lists.infradead.org, xlpang@redhat.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, dyoung@redhat.com

On 09/20/16 at 06:03pm, Jonathan Corbet wrote:
> On Mon, 19 Sep 2016 13:59:46 +0800
> Baoquan He <bhe@redhat.com> wrote:
> 
> > This is v10 post. In this patchset patch 1/3 is added to give more details
> > about nr_cpus and maxcpus in kernel-parameters.txt. This is suggested by
> > Jonathan since the description of them is unclear so that people can't see
> > what's the exact difference between them. Otherwise no big further change
> > for 2/3 and 3/3 which comprise the old post.
> 
> So somehow I'd applied 1/3 a while back, but not the other two.  All three
> are in the docs tree now, thanks.

Thanks!


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
