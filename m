Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aRQ2J-0000UL-3d
 for kexec@lists.infradead.org; Thu, 04 Feb 2016 19:57:51 +0000
Date: Thu, 4 Feb 2016 20:57:29 +0100
From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [PATCH v3 18/22] kexec: replace call to copy_file_from_fd() with
 kernel version
Message-ID: <20160204195729.GG12481@wotan.suse.de>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-19-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1454526390-19792-19-git-send-email-zohar@linux.vnet.ibm.com>
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Wed, Feb 03, 2016 at 02:06:26PM -0500, Mimi Zohar wrote:
> Replace copy_file_from_fd() with kernel_read_file_from_fd().
> 
> Two new identifiers named READING_KEXEC_IMAGE and READING_KEXEC_INITRAMFS
> are defined for measuring, appraising or auditing the kexec image and
> initramfs.
> 
> Changelog v3:
> - return -EBADF, not -ENOEXEC
> - identifier change
> - moved copy_file_from_fd() to a separate patch
> - defer support for IMA
> v1:
> - re-order and squash the kexec patches
> v0: ima: measure and appraise kexec image and initramfs (squashed)
> - rename ima_read_hooks enumeration to ima_policy_id
> - use kstat file size type loff_t, not size_t
> - add union name "hooks" to fix sparse warning
> - Calculate the file hash from the in memory buffer
> (suggested by Dave Young)
> - Rename ima_read_and_process_file() to ima_hash_and_process_file()
> - replace individual case statements with range:
>         KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1
> - Instead of ima_read_and_process_file() allocating memory, the caller
> allocates and frees the memory.
> - Moved the kexec measurement/appraisal call to copy_file_from_fd(). The
> same call now measures and appraises both the kexec image and initramfs.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
