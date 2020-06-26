Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from linux.microsoft.com ([13.77.154.182])
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jox0I-00039f-3F
 for kexec@lists.infradead.org; Fri, 26 Jun 2020 22:39:27 +0000
From: Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: [PATCH v2 00/11] ima: Fix rule parsing bugs and extend KEXEC_CMDLINE
 rule support
Date: Fri, 26 Jun 2020 17:38:49 -0500
Message-Id: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
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
To: Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Janne Karhunen <janne.karhunen@gmail.com>, Prakhar Srivastava <prsriva02@gmail.com>, kexec@lists.infradead.org, James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>

This series ultimately extends the supported IMA rule conditionals for
the KEXEC_CMDLINE hook function. As of today, there's an imbalance in
IMA language conditional support for KEXEC_CMDLINE rules in comparison
to KEXEC_KERNEL_CHECK and KEXEC_INITRAMFS_CHECK rules. The KEXEC_CMDLINE
rules do not support *any* conditionals so you cannot have a sequence of
rules like this:

 dont_measure func=KEXEC_KERNEL_CHECK obj_type=foo_t
 dont_measure func=KEXEC_INITRAMFS_CHECK obj_type=foo_t
 dont_measure func=KEXEC_CMDLINE obj_type=foo_t
 measure func=KEXEC_KERNEL_CHECK
 measure func=KEXEC_INITRAMFS_CHECK
 measure func=KEXEC_CMDLINE

Instead, KEXEC_CMDLINE rules can only be measured or not measured and
there's no additional flexibility in today's implementation of the
KEXEC_CMDLINE hook function.

With this series, the above sequence of rules becomes valid and any
calls to kexec_file_load() with a kernel and initramfs inode type of
foo_t will not be measured (that includes the kernel cmdline buffer)
while all other objects given to a kexec_file_load() syscall will be
measured. There's obviously not an inode directly associated with the
kernel cmdline buffer but this patch series ties the inode based
decision making for KEXEC_CMDLINE to the kernel's inode. I think this
will be intuitive to policy authors.

While reading IMA code and preparing to make this change, I realized
that the buffer based hook functions (KEXEC_CMDLINE and KEY_CHECK) are
quite special in comparison to longer standing hook functions. These
buffer based hook functions can only support measure actions and there
are some restrictions on the conditionals that they support. However,
the rule parser isn't enforcing any of those restrictions and IMA policy
authors wouldn't have any immediate way of knowing that the policy that
they wrote is invalid. For example, the sequence of rules above parses
successfully in today's kernel but the
"dont_measure func=KEXEC_CMDLINE ..." rule is incorrectly handled in
ima_match_rules(). The dont_measure rule is *always* considered to be a
match so, surprisingly, no KEXEC_CMDLINE measurements are made.

While making the rule parser more strict, I realized that the parser
does not correctly free all of the allocated memory associated with an
ima_rule_entry when going down some error paths. Invalid policy loaded
by the policy administrator could result in small memory leaks.

I envision patches 1-6 going to stable. The series is ordered in a way
that has all the fixes up front, followed by cleanups, followed by the
feature patch. The breakdown of patches looks like so:

 Memory leak fixes: 1-3
 Parser strictness fixes: 4-6
 Code cleanups made possible by the fixes: 7-10
 Extend KEXEC_CMDLINE rule support: 11

Perhaps the most logical ordering for code review is:

 1, 2, 3, 7, 8, 4, 5, 6, 9, 10, 11

If you'd like me to re-order or split up the series, just let me know.
Thanks for considering these patches!

* Series-wide v2 changes
  - Rebased onto next-integrity-testing
  - Squashed patches 2 and 3 from v1
    + Updated this cover letter to account for changes to patch index
      changes
    + See patch 2 for specific code changes

Tyler

Tyler Hicks (11):
  ima: Have the LSM free its audit rule
  ima: Free the entire rule when deleting a list of rules
  ima: Free the entire rule if it fails to parse
  ima: Fail rule parsing when buffer hook functions have an invalid
    action
  ima: Fail rule parsing when the KEXEC_CMDLINE hook is combined with an
    invalid cond
  ima: Fail rule parsing when the KEY_CHECK hook is combined with an
    invalid cond
  ima: Shallow copy the args_p member of ima_rule_entry.lsm elements
  ima: Use correct type for the args_p member of ima_rule_entry.lsm
    elements
  ima: Move validation of the keyrings conditional into
    ima_validate_rule()
  ima: Use the common function to detect LSM conditionals in a rule
  ima: Support additional conditionals in the KEXEC_CMDLINE hook
    function

 include/linux/ima.h                          |   4 +-
 kernel/kexec_file.c                          |   2 +-
 security/integrity/ima/ima.h                 |   7 +-
 security/integrity/ima/ima_api.c             |   2 +-
 security/integrity/ima/ima_appraise.c        |   2 +-
 security/integrity/ima/ima_asymmetric_keys.c |   2 +-
 security/integrity/ima/ima_main.c            |  23 ++-
 security/integrity/ima/ima_policy.c          | 161 ++++++++++++++-----
 security/integrity/ima/ima_queue_keys.c      |   2 +-
 9 files changed, 148 insertions(+), 57 deletions(-)

-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
