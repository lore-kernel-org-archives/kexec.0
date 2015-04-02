Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <551CCC67.1040607@redhat.com>
Date: Thu, 02 Apr 2015 10:28:15 +0530
From: Pratyush Anand <panand@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/5] arm64: add kdump support
References: <1427358533-3754-1-git-send-email-takahiro.akashi@linaro.org>
 <551C1537.2030009@redhat.com> <551C7EF5.9030806@linaro.org>
In-Reply-To: <551C7EF5.9030806@linaro.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, catalin.marinas@arm.com, will.deacon@arm.com, vgoyal@redhat.com, hbabus@us.ibm.com
Cc: linaro-kernel@lists.linaro.org, geoff@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, broonie@kernel.org, david.griego@linaro.org, linux-arm-kernel@lists.infradead.org



On Thursday 02 April 2015 04:57 AM, AKASHI Takahiro wrote:
> Please try my latest kexec-tools in my linaro repo (branch name is
> kdump/v0.11)
> and let me know the result.

Thanks a lot.. Just fetched your repo and found v.0.11.

With this crash kernel loaded successfully, if I do not use initrd.

With following I still see Overlapping memory segments

kexec -p  /home/panand/work/kernel/bsa2_kdump/vmlinux 
--initrd=/boot/initramfs-3.19.0.bz1198945+.img --append="$( cat 
/proc/cmdline ) maxcpus=1 mem=64M reset_devices"

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
