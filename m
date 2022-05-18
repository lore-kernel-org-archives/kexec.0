From: Heiko Carstens <hca@linux.ibm.com>
Date: Wed, 18 May 2022 13:29:31 +0200
Subject: [PATCH v8 4/4] kexec, KEYS, s390: Make use of built-in and
 secondary keyring for signature verification
In-Reply-To: <20220512070123.29486-5-coxu@redhat.com>
References: <20220512070123.29486-1-coxu@redhat.com>
 <20220512070123.29486-5-coxu@redhat.com>
Message-ID: <YoTYm6Fo1vBUuJGu@osiris>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Thu, May 12, 2022 at 03:01:23PM +0800, Coiby Xu wrote:
> From: Michal Suchanek <msuchanek@suse.de>
> 
> commit e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
> adds support for KEXEC_SIG verification with keys from platform keyring
> but the built-in keys and secondary keyring are not used.
> 
> Add support for the built-in keys and secondary keyring as x86 does.
> 
> Fixes: e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
> Cc: stable at vger.kernel.org
> Cc: Philipp Rudo <prudo@linux.ibm.com>
> Cc: kexec at lists.infradead.org
> Cc: keyrings at vger.kernel.org
> Cc: linux-security-module at vger.kernel.org
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  arch/s390/kernel/machine_kexec_file.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)

As far as I can tell this doesn't have any dependency to the other
patches in this series, so should I pick this up for the s390 tree, or
how will this go upstream?

In any case:
Acked-by: Heiko Carstens <hca@linux.ibm.com>

