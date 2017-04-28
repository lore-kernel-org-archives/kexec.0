Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d3zN2-0005RS-4T
 for kexec@lists.infradead.org; Fri, 28 Apr 2017 06:27:13 +0000
Date: Fri, 28 Apr 2017 14:26:14 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [Makedumpfile PATCH 0/2] Fix refiltering when kaslr enabled
Message-ID: <20170428062614.GB2649@x1>
References: <cover.1493272570.git.panand@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1493272570.git.panand@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: keescook@chromium.org, dyoung@redhat.com, ats-kumagai@wm.jp.nec.com, kexec@lists.infradead.org, yinghai@kernel.org, mingo@kernel.org


Usually we can use gdb to debug the running kernel like this:
gdb vmlinux /proc/kcore

However now it doesn't work any more since those kernel symbols are got
at compiling time, while kaslr-ed kernel do relocation on them. Don't
know if this will impact anything else.

On 04/27/17 at 11:45am, Pratyush Anand wrote:
> Hi All,
> 
> We came across another failure in makedumpfile when kaslr is enabled. This
> failure occurs when we try re-filtering. We try to erase some symbol from a
> dumpfile which was copied/compressed from /proc/vmcore using makedumpfile.
> 
> We have very limited symbol information in vmcoreinfo. So symbols to be
> erased may not be available in vmcoreinfo and we look for it in vmlinux.
> However,  symbol address from vmlinux is a static address which differs
> from run time address with KASLR_OFFSET. Therefore, reading any "virtual
> address of vmlinux" from vmcore is not possible. 
> 
> These patches finds runtime  KASLR offset and then calculates run time
> address of symbols read from vmlinux.
> 
> Since, I am not an expert of x86, and these patches touch x86 part of
> makedumpfile, therefore I have CCed x86 experts. Please, provide your
> review comment and let me know if you think there could have been a better
> way to resolve this issue.
> 
> thanks
> 
> ~Pratyush
> 
> Pratyush Anand (2):
>   makedumpfile: add runtime kaslr offset if it exists
>   x86_64: calculate page_offset in case of re-filtering
> 
>  arch/x86_64.c  | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  erase_info.c   |  1 +
>  makedumpfile.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  makedumpfile.h | 15 +++++++++++++++
>  4 files changed, 103 insertions(+), 2 deletions(-)
> 
> -- 
> 2.9.3
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
