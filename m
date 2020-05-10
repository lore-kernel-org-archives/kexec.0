Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jXeKp-0004qm-OJ
 for kexec@lists.infradead.org; Sun, 10 May 2020 05:17:09 +0000
Date: Sun, 10 May 2020 13:16:46 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3] kernel: add panic_on_taint
Message-ID: <20200510051646.GF5029@MiWiFi-R3L-srv>
References: <20200509135737.622299-1-aquini@redhat.com>
 <20200510025921.GA10165@MiWiFi-R3L-srv>
 <acab7971-7522-3511-c976-e0237ceda4d0@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <acab7971-7522-3511-c976-e0237ceda4d0@infradead.org>
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
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Rafael Aquini <aquini@redhat.com>, linux-doc@vger.kernel.org, tiwai@suse.de, jeffm@suse.com, corbet@lwn.net, labbott@redhat.com, dyoung@redhat.com, AnDavis@suse.com, rpalethorpe@suse.de, keescook@chromium.org, jikos@kernel.org, cai@lca.pw, bunk@kernel.org, tytso@mit.edu, jeyu@suse.de, gregkh@linuxfoundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org

On 05/09/20 at 09:10pm, Randy Dunlap wrote:
> On 5/9/20 7:59 PM, Baoquan He wrote:
> > Read admin-guide/tainted-kernels.rst, but still do not get what 'G' means.
> 
> I interpret 'G' as GPL (strictly it means that no proprietary module has
> been loaded).  But I don't see why TAINT_PROPRIETARY_MODULE is the only
> taint flag that has a non-blank c_false character.  It could just be blank
> also AFAICT.  Then the 'G' would not be there to confuse us.  :)

Yeah, seems c_false character is not so necessary. If no 'P' set, then
it means no proprietary modules loaded naturally. We may need clean up
the c_false in struct taint_flag, since c_true is enough to indicate
what want to check.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
