Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
MIME-Version: 1.0
Date: Wed, 10 Apr 2013 17:35:00 +0800
Message-ID: <CAFNq8R5FFUyH+JgjoGc5ctgEfiLvxzi7fzawM7+wFX5nEyTv-w@mail.gmail.com>
Subject: Kexec couldn't reboot capture kernel on pandaboard ES with OMAP4460
From: Li Haifeng <omycle@gmail.com>
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
To: pandaboard@googlegroups.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org

Hi, everyone.

Recently, I try to run kdump on pandaboard ES with omap4460. After
load capture kernel by "kexec -l" and execute "kexec -e", the serial
port output "Starting new kernel" and "Bye", then the system hangs up.

I have tried the upstream Linux Kernel v3.4 and v3.8. All are with this issue.

Could you tell my why and how to solve this issue?

Thanks very much.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
