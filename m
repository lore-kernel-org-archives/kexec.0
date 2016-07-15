Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 15 Jul 2016 09:09:55 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC 3/3] kexec: extend kexec_file_load system call
Message-ID: <20160715130955.GC23514@redhat.com>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160712014201.11456-4-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160712014201.11456-4-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: bhe@redhat.com, arnd@arndb.de, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

On Tue, Jul 12, 2016 at 10:42:01AM +0900, AKASHI Takahiro wrote:

[..]
> -SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> +SYSCALL_DEFINE6(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  		unsigned long, cmdline_len, const char __user *, cmdline_ptr,
> -		unsigned long, flags)
> +		unsigned long, flags, const struct kexec_fdset __user *, ufdset)

Can one add more parameters to existing syscall. Can it break existing
programs with new kernel? I was of the impression that one can't do that.
But may be I am missing something.

Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
