Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <54AE2544.2010801@huawei.com>
Date: Thu, 8 Jan 2015 12:05:48 +0530
From: Anurup M <anurup.m@huawei.com>
MIME-Version: 1.0
Subject: Kdump on ARM64
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
To: kexec@lists.infradead.org
Cc: geoff@infradead.org, takahiro.akashi@linaro.org, sanil.kumar@hisilicon.com

Hi Akashi, Geoff,

	I tried to check kdump on arm64 on Foundation model. The/proc/vmcore is generated.
But I couldnot check if it is proper. Is there a makedumpfile binary for arm64? and also crash tool.
I used the master branch of https://git.linaro.org/people/geoff.levand/linux-kexec.git to verify.
 	Please provide some information about the current status or support for kdump on arm64?
and the ways to verify or start development on Foundation model.

Thanks,
Anurup M

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
