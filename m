Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ez8qc-0004Vt-DN
 for kexec@lists.infradead.org; Thu, 22 Mar 2018 22:38:15 +0000
Date: Thu, 22 Mar 2018 15:38:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2] Kexec_file: Load kernel at top of system ram
Message-Id: <20180322153802.0763bb46978c0c1a3d3f11c0@linux-foundation.org>
In-Reply-To: <20180322033722.9279-1-bhe@redhat.com>
References: <20180322033722.9279-1-bhe@redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: prudo@linux.vnet.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, takahiro.akashi@linaro.org, ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com

On Thu, 22 Mar 2018 11:37:20 +0800 Baoquan He <bhe@redhat.com> wrote:

> The current kexec_file ignores kexec_buf.top_down value when call
> arch_kexec_walk_mem() to allocate memory for loading kernel/initrd
> stuffs. This is not supposed to be what kexec_buf.top_down is used
> for.

OK, but why is this a problem?  When fixing a bug, please fully
describe the user-visible effects of that bug.  That helps others
understand the importance of the fix, whether it should be backported
into various kernels, etc.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
