Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Message-ID: <51658B1A.6090706@wwwdotorg.org>
Date: Wed, 10 Apr 2013 09:54:02 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
Subject: Re: Kexec couldn't reboot capture kernel on pandaboard ES with
 OMAP4460
References: <CAFNq8R5FFUyH+JgjoGc5ctgEfiLvxzi7fzawM7+wFX5nEyTv-w@mail.gmail.com>
In-Reply-To: <CAFNq8R5FFUyH+JgjoGc5ctgEfiLvxzi7fzawM7+wFX5nEyTv-w@mail.gmail.com>
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
To: Li Haifeng <omycle@gmail.com>
Cc: linux-omap@vger.kernel.org, pandaboard@googlegroups.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On 04/10/2013 03:35 AM, Li Haifeng wrote:
> Hi, everyone.
> 
> Recently, I try to run kdump on pandaboard ES with omap4460. After
> load capture kernel by "kexec -l" and execute "kexec -e", the serial
> port output "Starting new kernel" and "Bye", then the system hangs up.
> 
> I have tried the upstream Linux Kernel v3.4 and v3.8. All are with this issue.

This is a shot in the dark. I assume you have SMP enabled. Can you use
hotplug to remove all CPUs other than CPU0, so that the kexec happens on
the boot CPU? That is certainly necessary for kexec to work correctly on
Tegra.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
