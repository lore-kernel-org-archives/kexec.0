Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g2t2353.austin.hpe.com ([15.233.44.26])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f8XIy-0000hr-19
 for kexec@lists.infradead.org; Tue, 17 Apr 2018 20:34:21 +0000
Date: Tue, 17 Apr 2018 14:34:05 -0600
From: Randy Wright <rwright@hpe.com>
Subject: Re: [PATCH] efi: Fix the size not consistent issue when unmapping
 memory map
Message-ID: <20180417203405.GA4574@rfwz>
References: <20180413062716.8040-1-jlee@suse.com>
 <20180416025734.GA26685@dhcp-128-65.nay.redhat.com>
 <20180416030904.GB26685@dhcp-128-65.nay.redhat.com>
 <20180416063738.GH16023@linux-l9pv.suse>
 <20180417003522.GA2741@rfwz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180417003522.GA2741@rfwz>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: rwright@hpe.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: joeyli <jlee@suse.com>, dyoung@redhat.com
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Takashi Iwai <tiwai@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, akpm@linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Mon, Apr 16, 2018 at 06:35:22PM -0600, Randy Wright wrote:

> ... I will plan to run the same test tomorrow on
> a build of the SuSE 4.4.120-94.17 kernel, on which I had also reported
> the original bug.

I carried out the test on the older kernel today. I found the version of
arch/x86/kernel/kexec-bzimage64.c in the SuSE kernel version
4.4.120-94.17 was sufficiently different from the newer version that one
chunk of the patch under discussion was rejected.  Specifically, the
'struct kexec_buf kbuf' is not found in that older SuSE version of
kexec-bzimage64.c.   But I made the same modification to the
calculation of variable params_misc_sz in the older source, ran the same
test, and there were no longer any warnings from early_ioremap.c.

-- 
Randy Wright            Hewlett Packard Enterprise
Phone: (970) 898-0998   Mail: rwright@hpe.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
