Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tex.lwn.net ([70.33.254.29] helo=vena.lwn.net)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bmV1K-0006Pj-Br
 for kexec@lists.infradead.org; Wed, 21 Sep 2016 00:04:15 +0000
Date: Tue, 20 Sep 2016 18:03:46 -0600
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v10 RESEND 0/3] Documentation: Add description of enable
 multi-cpus support for kdump
Message-ID: <20160920180346.595fd720@lwn.net>
In-Reply-To: <1474264789-11705-1-git-send-email-bhe@redhat.com>
References: <1474264789-11705-1-git-send-email-bhe@redhat.com>
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
Cc: linux-doc@vger.kernel.org, kexec@lists.infradead.org, xlpang@redhat.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, dyoung@redhat.com

On Mon, 19 Sep 2016 13:59:46 +0800
Baoquan He <bhe@redhat.com> wrote:

> This is v10 post. In this patchset patch 1/3 is added to give more details
> about nr_cpus and maxcpus in kernel-parameters.txt. This is suggested by
> Jonathan since the description of them is unclear so that people can't see
> what's the exact difference between them. Otherwise no big further change
> for 2/3 and 3/3 which comprise the old post.

So somehow I'd applied 1/3 a while back, but not the other two.  All three
are in the docs tree now, thanks.

jon

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
