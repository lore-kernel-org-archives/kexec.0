Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aM36P-0007m2-ER
 for kexec@lists.infradead.org; Thu, 21 Jan 2016 00:27:53 +0000
Received: by mail-pf0-x234.google.com with SMTP id q63so13534462pfb.1
 for <kexec@lists.infradead.org>; Wed, 20 Jan 2016 16:27:33 -0800 (PST)
Date: Wed, 20 Jan 2016 16:27:29 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH v2 06/11] kexec: replace call to copy_file_from_fd()
 with kernel version
Message-ID: <20160121002729.GB26369@dtor-ws>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-7-git-send-email-zohar@linux.vnet.ibm.com>
 <20160120231240.GL11277@wotan.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160120231240.GL11277@wotan.suse.de>
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
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, Julia Lawall <julia.lawall@lip6.fr>, linux-security-module@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-modules@vger.kernel.org

On Thu, Jan 21, 2016 at 12:12:40AM +0100, Luis R. Rodriguez wrote:
> On Mon, Jan 18, 2016 at 10:11:21AM -0500, Mimi Zohar wrote:
> > diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> > index 4edf47f..3adf937 100644
> > --- a/security/integrity/ima/ima_appraise.c
> > +++ b/security/integrity/ima/ima_appraise.c
> > @@ -78,6 +78,8 @@ enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
> >  		return iint->ima_module_status;
> >  	case FIRMWARE_CHECK:
> >  		return iint->ima_firmware_status;
> > +	case KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1:
> > +		return iint->ima_read_status;
> 
> I didn't get the memo that we're OK to use compiler specific extensions
> like this. I'm sure if you are using it its not the first case, just
> want to be sure we are aware of possible issues if some compiler doesn't
> support this.
> 
> If we don't have a precedence can we just avoid its use?

This has sailed:

dtor@dtor-ws:~$ grep -rl 'case.*\.\.\..*:' kernel/work/drivers/ | wc -l
98

Thanks.

-- 
Dmitry

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
