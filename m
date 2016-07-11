Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 11 Jul 2016 11:10:44 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [RFC] arm64: kexec_file_load support
Message-ID: <20160711031044.GA2850@dhcp-128-65.nay.redhat.com>
References: <20160701051111.GL20774@linaro.org>
 <20160705080355.GQ20774@linaro.org>
 <20160707061245.GA18459@dhcp-128-65.nay.redhat.com>
 <11139482.zLvCKVycQr@hactar>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <11139482.zLvCKVycQr@hactar>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, bhe@redhat.com, kexec@lists.infradead.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, ebiederm@xmission.com, catalin.marinas@arm.com, linuxppc-dev@lists.ozlabs.org, vgoyal@redhat.com

On 07/08/16 at 11:48am, Thiago Jung Bauermann wrote:
> Am Donnerstag, 07 Juli 2016, 14:12:45 schrieb Dave Young:
> > If so maybe change a bit from your precious mentioned 7 args proposal like
> > below?
> > 
> > struct kexec_file_fd {
> > 	enum kexec_file_type;
> > 	int fd;
> > }
> > 
> > struct kexec_fdset {
> > 	int nr_fd;
> > 	struct kexec_file_fd fd[0];
> > }
> > 
> > int kexec_file_load(int kernel_fd, int initrd_fd,
> > 		    unsigned long cmdline_len, const char *cmdline_ptr,
> > 		    unsigned long flags, struct kexec_fdset *extra_fds);
> 
> 
> Is there a way for the kernel to distinguish whether the process passed 5 or 
> 6 arguments? How can it know whether extra_fds is a valid argument or just 
> garbage? I think we have to define a new flag KEXEC_FILE_EXTRA_FDS so that 
> the process can signal that it is using the new interface.

Agreed, a new flag is needed.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
