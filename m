Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmk5o-00H9El-1o
 for kexec@lists.infradead.org; Mon, 15 Nov 2021 22:04:49 +0000
Date: Mon, 15 Nov 2021 14:04:44 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] proc/vmcore: fix clearing user buffer by properly
 using clear_user()
Message-Id: <20211115140444.bca2b88cfdd992760a413442@linux-foundation.org>
In-Reply-To: <20211112092750.6921-1-david@redhat.com>
References: <20211112092750.6921-1-david@redhat.com>
Mime-Version: 1.0
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
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org

On Fri, 12 Nov 2021 10:27:50 +0100 David Hildenbrand <david@redhat.com> wrote:

> To clear a user buffer we cannot simply use memset, we have to use
> clear_user(). With a virtio-mem device that registers a vmcore_cb and has
> some logically unplugged memory inside an added Linux memory block, I can
> easily trigger a BUG by copying the vmcore via "cp":
> 
> ...
>
> Some x86-64 CPUs have a CPU feature called "Supervisor Mode Access
> Prevention (SMAP)", which is used to detect wrong access from the kernel to
> user buffers like this: SMAP triggers a permissions violation on wrong
> access. In the x86-64 variant of clear_user(), SMAP is properly
> handled via clac()+stac().
> 
> To fix, properly use clear_user() when we're dealing with a user buffer.
> 

I added cc:stable, OK?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
