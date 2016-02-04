Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aRPwR-00062e-0B
 for kexec@lists.infradead.org; Thu, 04 Feb 2016 19:51:47 +0000
Date: Thu, 4 Feb 2016 20:51:24 +0100
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v3 13/22] firmware: replace call to
 fw_read_file_contents() with kernel version
Message-ID: <20160204195124.GC12481@wotan.suse.de>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-14-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1454526390-19792-14-git-send-email-zohar@linux.vnet.ibm.com>
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

On Wed, Feb 03, 2016 at 02:06:21PM -0500, Mimi Zohar wrote:
> Replace the fw_read_file_contents with kernel_file_read_from_path().
> 
> Although none of the upstreamed LSMs define a kernel_fw_from_file hook,
> IMA is called by the security function to prevent unsigned firmware from
> being loaded and to measure/appraise signed firmware, based on policy.
> 
> Instead of reading the firmware twice, once for measuring/appraising the
> firmware and again for reading the firmware contents into memory, the
> kernel_post_read_file() security hook calculates the file hash based on
> the in memory file buffer.  The firmware is read once.
> 
> This patch removes the LSM kernel_fw_from_file() hook and security call.
> 
> Changelog v3:
> - remove kernel_fw_from_file hook
> - use kernel_file_read_from_path() - requested by Luis
> v2:
> - reordered and squashed firmware patches
> - fix MAX firmware size (Kees Cook)
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

 Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
