Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8iyJ-0003V9-9Z
 for kexec@lists.infradead.org; Tue, 26 Mar 2019 10:06:21 +0000
Date: Tue, 26 Mar 2019 11:06:13 +0100
In-Reply-To: <be457f42-40b0-6d21-0f0c-2a5e3860d4d5@amd.com>
References: <20190315103203.13128-1-lijiang@redhat.com>
 <20190315103203.13128-2-lijiang@redhat.com> <20190324150034.GH23289@zn.tnic>
 <7b115829-40d9-e55e-dee3-ec8e4766971f@redhat.com>
 <20190325063742.GA12016@zn.tnic>
 <652b9166-f06e-c210-3c3f-c9e80a97db18@amd.com>
 <20190325173239.GO12016@zn.tnic>
 <11013ad2-2eab-5a7a-d4e2-a9da4920cfab@amd.com>
 <be457f42-40b0-6d21-0f0c-2a5e3860d4d5@amd.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] kexec: Do not map the kexec area as decrypted when
 SEV is active
From: Boris Petkov <bp@alien8.de>
Message-ID: <24AEA0F0-8BDA-4C96-9AC2-F12A7A06C76D@alien8.de>
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
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Singh,
 Brijesh" <brijesh.singh@amd.com>
Cc: lijiang <lijiang@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "dyoung@redhat.com" <dyoung@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

On March 25, 2019 8:59:28 PM GMT+01:00, "Lendacky, Thomas" <Thomas.Lendacky@amd.com> wrote:
>Maybe what would help is to describe why there is a difference between
>SME
>and SEV in regards to kexec. During a traditional boot under SME, SME
>will
>encrypt the kernel, so the SME kexec kernel also needs to be
>un-encrypted
>in order to replicate a normal SME boot. During a traditional boot
>under
>SEV, the kernel has already been loaded encrypted, so the SEV kexec
>kernel
>needs to be encrypted in order to replicate a normal SEV boot.


Yah, that should be in a comment above that function.

Thx.

-- 
Sent from a small device: formatting sux and brevity is inevitable. 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
