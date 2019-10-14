Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH V4 0/2] Add support for arm64 to carry ima measurement
References: <20191011003600.22090-1-prsriva@linux.microsoft.com>
From: James Morse <james.morse@arm.com>
Message-ID: <87d92514-e5e4-a79f-467f-f24a4ed279b6@arm.com>
Date: Mon, 14 Oct 2019 19:02:28 +0100
MIME-Version: 1.0
In-Reply-To: <20191011003600.22090-1-prsriva@linux.microsoft.com>
Content-Language: en-GB
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
To: Prakhar Srivastava <prsriva@linux.microsoft.com>
Cc: mark.rutland@arm.com, jean-philippe@linaro.org, arnd@arndb.de, yamada.masahiro@socionext.com, sboyd@kernel.org, catalin.marinas@arm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, takahiro.akashi@linaro.org, kristina.martsenko@arm.org, duwe@lst.de, bauerman@linux.ibm.com, allison@lohutok.net, james.morse@arm.org, linux-integrity@vger.kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org

Hi Prakhar,

(You've CC'd a few folk who work for 'arm.org'...)

On 11/10/2019 01:35, Prakhar Srivastava wrote:
> Add support to carry ima measurement log
> to the next kexec'ed session triggered via kexec_file_load.

I don't know much about 'ima', I'm assuming its the list of 'stuff' that has already been
fed into the TPM as part of SecureBoot. Please forgive the stupid questions,


> Currently during kexec the kernel file signatures are/can be validated
> prior to actual load, the information(PE/ima signature) is not carried
> to the next session. This lead to loss of information.
> 
> Carrying forward the ima measurement log to the next kexec'ed session 
> allows a verifying party to get the entire runtime event log since the
> last full reboot, since that is when PCRs were last reset.

Hmm, You're adding this as a linux-specific thing in the chosen node, which points at a
memreserve.

The question that normally needs answering when adding to the stuff we have to treat as
ABI over kexec is: how would this work from a bootloader that isn't kexec? Does it need to
work for non-linux OS?

Changing anything other than the chosen node of the DT isn't something the kernel should
be doing. I suspect if you need reserved memory for this stuff, it should be carved out by
the bootloader, and like all other memreserves: should not be moved or deleted.

('fdt_delete_mem_rsv()' is a terrifying idea, we depend on the memreserve nodes to tell
use which 'memory' we shouldn't touch!)


Sharing with powerpc is a great starting point ... but, how does this work for ACPI systems?
How does this work if I keep kexecing between ACPI and DT?

I'd prefer it we only had one way this works on arm64, so whatever we do has to cover both.

Does ima work without UEFI secure-boot?
If not, the Linux-specific UEFI 'memreserve' table might be a better fit, this would be
the same for both DT and ACPI systems. Given U-boot supports the UEFI API too, its
probably the right thing to do regardless of secure-boot.

It looks like x86 doesn't support this either yet. If we have to add something to support
ACPI, it would be good if it covers both firmware mechanisms for arm64, and works for x86
in the same way.

(How does this thing interact with EFI's existing efi_tpm_eventlog_init()?)


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
