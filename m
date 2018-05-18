Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from namei.org ([65.99.196.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fJix3-00058R-4e
 for kexec@lists.infradead.org; Fri, 18 May 2018 17:13:58 +0000
Date: Sat, 19 May 2018 03:13:37 +1000 (AEST)
From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH v2 3/9] security: define security_kernel_read_blob()
 wrapper
In-Reply-To: <87y3ghhbws.fsf@xmission.com>
Message-ID: <alpine.LRH.2.21.1805190303100.26396@namei.org>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1526568530-9144-4-git-send-email-zohar@linux.vnet.ibm.com>
 <74c096ca-1ad1-799e-df3d-7b1b099333a7@schaufler-ca.com>
 <87y3ghhbws.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, "Luis R . Rodriguez" <mcgrof@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>, Andres Rodriguez <andresx7@gmail.com>

On Thu, 17 May 2018, Eric W. Biederman wrote:

> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Nack on this sharing nonsense.  These two interfaces do not share any
> code in their implementations other than the if statement to distinguish
> between the two cases.

Hmm, it's not even doing that.

There's already an if(!file && read_id == X) { } check and this is another 
one being added.

> If we want comprehensible and maintainable code in the security modules
> we need to split these two pieces of functionality apart.

All ima_read is doing in both the old and new case is checking if there's 
no file then if it's a certain operation, returning an error.

To echo Eric and Casey's suggestions, how about changing the name of the 
hook to security_kernel_read_data() ?

Then ima_read_file() can be changed to ima_read_data(), and then instead 
of two if (!file && read_id == X) checks, have:

	if (!file) {
		switch (read_id) {
		}
	}




-- 
James Morris
<jmorris@namei.org>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
