From: Baoquan He <bhe@redhat.com>
Date: Thu, 19 May 2022 08:39:02 +0800
Subject: [PATCH v8 4/4] kexec, KEYS, s390: Make use of built-in and
 secondary keyring for signature verification
In-Reply-To: <YoTYm6Fo1vBUuJGu@osiris>
References: <20220512070123.29486-1-coxu@redhat.com>
 <20220512070123.29486-5-coxu@redhat.com> <YoTYm6Fo1vBUuJGu@osiris>
Message-ID: <20220519003902.GE156677@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 05/18/22 at 01:29pm, Heiko Carstens wrote:
> On Thu, May 12, 2022 at 03:01:23PM +0800, Coiby Xu wrote:
> > From: Michal Suchanek <msuchanek@suse.de>
> > 
> > commit e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
> > adds support for KEXEC_SIG verification with keys from platform keyring
> > but the built-in keys and secondary keyring are not used.
> > 
> > Add support for the built-in keys and secondary keyring as x86 does.
> > 
> > Fixes: e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
> > Cc: stable at vger.kernel.org
> > Cc: Philipp Rudo <prudo@linux.ibm.com>
> > Cc: kexec at lists.infradead.org
> > Cc: keyrings at vger.kernel.org
> > Cc: linux-security-module at vger.kernel.org
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
> > Acked-by: Baoquan He <bhe@redhat.com>
> > Signed-off-by: Coiby Xu <coxu@redhat.com>
> > ---
> >  arch/s390/kernel/machine_kexec_file.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> As far as I can tell this doesn't have any dependency to the other
> patches in this series, so should I pick this up for the s390 tree, or
> how will this go upstream?

Thanks, Heiko.

I want to ask Mimi if this can be taken into KEYS-ENCRYPTED tree.
Otherwise I will ask Andrew to help pick this whole series.

Surely, this patch 4 can be taken into s390 seperately since it's
independent, both looks good.

Thanks
Baoquan


