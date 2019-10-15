Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 16 Oct 2019 09:15:39 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH V4 0/2] Add support for arm64 to carry ima measurement
In-Reply-To: <0053eb68-0905-4679-c97a-00c5cb6f1abb@arm.com>
Message-ID: <alpine.LRH.2.21.1910160914090.11167@namei.org>
References: <20191011003600.22090-1-prsriva@linux.microsoft.com>
 <87d92514-e5e4-a79f-467f-f24a4ed279b6@arm.com>
 <b35b239c-990c-0d5b-0298-8f9e35064e2b@linux.microsoft.com>
 <0053eb68-0905-4679-c97a-00c5cb6f1abb@arm.com>
MIME-Version: 1.0
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
To: James Morse <james.morse@arm.com>
Cc: mark.rutland@arm.com, jean-philippe@linaro.org, arnd@arndb.de, yamada.masahiro@socionext.com, sboyd@kernel.org, catalin.marinas@arm.com, ard.biesheuvel@linaro.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, prsriva <prsriva@linux.microsoft.com>, takahiro.akashi@linaro.org, duwe@lst.de, bauerman@linux.ibm.com, allison@lohutok.net, linux-integrity@vger.kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org

On Tue, 15 Oct 2019, James Morse wrote:

> > The IMA logs are event logs for module load time signature validation(based on policies)
> > which are backed by the TPM. No SecureBoot information is present in the log other than
> > the boot aggregate.
> 
> Okay, so SecureBoot is optional with this thing.

Correct. Verified boot is one alternative.


-- 
James Morris
<jmorris@namei.org>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
