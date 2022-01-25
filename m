From: Luis Chamberlain <mcgrof@kernel.org>
Date: Tue, 25 Jan 2022 12:30:52 -0800
Subject: [PATCH v5 0/6] KEXEC_SIG with appended signature
In-Reply-To: <cover.1641900831.git.msuchanek@suse.de>
References: <cover.1641900831.git.msuchanek@suse.de>
Message-ID: <YfBd/EDGUx9UIHcb@bombadil.infradead.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Tue, Jan 11, 2022 at 12:37:42PM +0100, Michal Suchanek wrote:
> Hello,
> 
> This is a refresh of the KEXEC_SIG series.
> 
> This adds KEXEC_SIG support on powerpc and deduplicates the code dealing
> with appended signatures in the kernel.
> 
> powerpc supports IMA_KEXEC but that's an exception rather than the norm.
> On the other hand, KEXEC_SIG is portable across platforms.
> 
> For distributions to have uniform security features across platforms one
> option should be used on all platforms.
> 
> Thanks
> 
> Michal
> 
> Previous revision: https://lore.kernel.org/linuxppc-dev/cover.1637862358.git.msuchanek at suse.de/
> Patched kernel tree: https://github.com/hramrach/kernel/tree/kexec_sig
> 
> Michal Suchanek (6):
>   s390/kexec_file: Don't opencode appended signature check.
>   powerpc/kexec_file: Add KEXEC_SIG support.
>   kexec_file: Don't opencode appended signature verification.
>   module: strip the signature marker in the verification function.
>   module: Use key_being_used_for for log messages in
>     verify_appended_signature
>   module: Move duplicate mod_check_sig users code to mod_parse_sig

What tree should this go through? I'd prefer if over through modules
tree as it can give a chance for Aaron Tomlin to work with this for his
code refactoring of kernel/module*.c to kernel/module/

  Luis

