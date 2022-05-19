From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 19 May 2022 07:56:25 -0400
Subject: [PATCH v8 4/4] kexec, KEYS, s390: Make use of built-in and
 secondary keyring for signature verification
In-Reply-To: <20220519003902.GE156677@MiWiFi-R3L-srv>
References: <20220512070123.29486-1-coxu@redhat.com>
 <20220512070123.29486-5-coxu@redhat.com> <YoTYm6Fo1vBUuJGu@osiris>
 <20220519003902.GE156677@MiWiFi-R3L-srv>
Message-ID: <c47299b899da4ad4b6d3ad637022ad82c8ed6ed2.camel@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

[Cc'ing Jarkko, linux-integrity]

On Thu, 2022-05-19 at 08:39 +0800, Baoquan He wrote:
> On 05/18/22 at 01:29pm, Heiko Carstens wrote:
> > On Thu, May 12, 2022 at 03:01:23PM +0800, Coiby Xu wrote:
> > > From: Michal Suchanek <msuchanek@suse.de>
> > > 
> > > commit e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
> > > adds support for KEXEC_SIG verification with keys from platform keyring
> > > but the built-in keys and secondary keyring are not used.
> > > 
> > > Add support for the built-in keys and secondary keyring as x86 does.
> > > 
> > > Fixes: e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
> > > Cc: stable at vger.kernel.org
> > > Cc: Philipp Rudo <prudo@linux.ibm.com>
> > > Cc: kexec at lists.infradead.org
> > > Cc: keyrings at vger.kernel.org
> > > Cc: linux-security-module at vger.kernel.org
> > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
> > > Acked-by: Baoquan He <bhe@redhat.com>
> > > Signed-off-by: Coiby Xu <coxu@redhat.com>
> > > ---
> > >  arch/s390/kernel/machine_kexec_file.c | 18 +++++++++++++-----
> > >  1 file changed, 13 insertions(+), 5 deletions(-)
> > 
> > As far as I can tell this doesn't have any dependency to the other
> > patches in this series, so should I pick this up for the s390 tree, or
> > how will this go upstream?
> 
> Thanks, Heiko.
> 
> I want to ask Mimi if this can be taken into KEYS-ENCRYPTED tree.
> Otherwise I will ask Andrew to help pick this whole series.
> 
> Surely, this patch 4 can be taken into s390 seperately since it's
> independent, both looks good.

KEYS-ENCRYTPED is a type of key, unrelated to using the .platform,
.builtin, .machine, or .secondary keyrings.  One of the main reasons
for this patch set is to use the new ".machine" keyring, which, if
enabled, is linked to the "secondary" keyring.  However, the only
reference to the ".machine" keyring is in the cover letter, not any of
the patch descriptions.  Since this is the basis for the system's
integrity, this seems like a pretty big omission.

From patch 2/4:
"The code in bzImage64_verify_sig makes use of system keyrings
including
.buitin_trusted_keys, .secondary_trusted_keys and .platform keyring to
verify signed kernel image as PE file..."

From patch 3/4:
"This patch allows to verify arm64 kernel image signature using not
only
.builtin_trusted_keys but also .platform and .secondary_trusted_keys
keyring."

From patch 4/4:
"... with keys from platform keyring but the built-in keys and
secondary keyring are not used."

This patch set could probably go through KEYS/KEYRINGS_INTEGRITY, but
it's kind of late to be asking.  Has it been in linux-next?  Should I
assume this patch set has been fully tested or can we get some "tags"?

thanks,

Mimi


