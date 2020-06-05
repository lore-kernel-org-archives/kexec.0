Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jhJrM-0002XX-CW
 for kexec@lists.infradead.org; Fri, 05 Jun 2020 21:26:42 +0000
Received: by mail-pl1-x641.google.com with SMTP id y18so4199350plr.4
 for <kexec@lists.infradead.org>; Fri, 05 Jun 2020 14:26:39 -0700 (PDT)
Date: Fri, 5 Jun 2020 14:26:36 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] kexec: dump kmessage before machine_kexec
Message-ID: <202006051426.4F06C696@keescook>
References: <20200605194642.62278-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200605194642.62278-1-pasha.tatashin@soleen.com>
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: sashal@kernel.org, pmladek@suse.com, tony.luck@intel.com, anton@enomsg.org, kexec@lists.infradead.org, jmorris@namei.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, ccross@android.com

On Fri, Jun 05, 2020 at 03:46:42PM -0400, Pavel Tatashin wrote:
> kmsg_dump(KMSG_DUMP_SHUTDOWN) is called before
> machine_restart(), machine_halt(), machine_power_off(), the only one that
> is missing is  machine_kexec().
> 
> The dmesg output that it contains can be used to study the shutdown
> performance of both kernel and systemd during kexec reboot.
> 
> Here is example of dmesg data collected after kexec:
> 
> root@dplat-cp22:~# cat /sys/fs/pstore/dmesg-ramoops-0 | tail
> ...
> <6>[   70.914592] psci: CPU3 killed (polled 0 ms)
> <5>[   70.915705] CPU4: shutdown
> <6>[   70.916643] psci: CPU4 killed (polled 4 ms)
> <5>[   70.917715] CPU5: shutdown
> <6>[   70.918725] psci: CPU5 killed (polled 0 ms)
> <5>[   70.919704] CPU6: shutdown
> <6>[   70.920726] psci: CPU6 killed (polled 4 ms)
> <5>[   70.921642] CPU7: shutdown
> <6>[   70.922650] psci: CPU7 killed (polled 0 ms)
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
