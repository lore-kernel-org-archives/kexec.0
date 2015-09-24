Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tex.lwn.net ([70.33.254.29] helo=vena.lwn.net)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZfEK0-0003MA-00
 for kexec@lists.infradead.org; Thu, 24 Sep 2015 21:44:56 +0000
Date: Thu, 24 Sep 2015 15:44:33 -0600
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: Update the default value of crashkernel low
Message-ID: <20150924154433.36989ba2@lwn.net>
In-Reply-To: <1443084685-1999-1-git-send-email-bhe@redhat.com>
References: <1443084685-1999-1-git-send-email-bhe@redhat.com>
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
Cc: akpm@linux-foundation.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, joro@8bytes.org

On Thu, 24 Sep 2015 16:51:25 +0800
Baoquan He <bhe@redhat.com> wrote:

> In commit 94fb933 ("x86/crash: Allocate enough low memory when
> crashkernel=high") the default value of crashkernel low memory
> is changed to 256M. In this patch update it accordingly.

Applied to the docs tree, thanks.

jon

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
