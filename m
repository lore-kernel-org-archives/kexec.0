From: Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 09 Feb 2022 15:43:17 +1100
Subject: [PATCH v5 2/6] powerpc/kexec_file: Add KEXEC_SIG support.
In-Reply-To: <d95f7c6865bcad5ee37dcbec240e79aa742f5e1d.1641900831.git.msuchanek@suse.de>
References: <cover.1641900831.git.msuchanek@suse.de>
 <d95f7c6865bcad5ee37dcbec240e79aa742f5e1d.1641900831.git.msuchanek@suse.de>
Message-ID: <87sfsslkey.fsf@mpe.ellerman.id.au>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Michal Suchanek <msuchanek@suse.de> writes:
> Copy the code from s390x
>
> Both powerpc and s390x use appended signature format (as opposed to EFI
> based patforms using PE format).
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> v3: - Philipp Rudo <prudo@redhat.com>: Update the comit message with
>       explanation why the s390 code is usable on powerpc.
>     - Include correct header for mod_check_sig
>     - Nayna <nayna@linux.vnet.ibm.com>: Mention additional IMA features
>       in kconfig text
> ---
>  arch/powerpc/Kconfig        | 16 ++++++++++++++++
>  arch/powerpc/kexec/elf_64.c | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)

I haven't tested this on powerpc, but assuming you have Michal this
looks OK to me.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

