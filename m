Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v3] kernel: add panic_on_taint
References: <20200509135737.622299-1-aquini@redhat.com>
 <20200510025921.GA10165@MiWiFi-R3L-srv>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <acab7971-7522-3511-c976-e0237ceda4d0@infradead.org>
Date: Sat, 9 May 2020 21:10:25 -0700
MIME-Version: 1.0
In-Reply-To: <20200510025921.GA10165@MiWiFi-R3L-srv>
Content-Language: en-US
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
To: Baoquan He <bhe@redhat.com>, Rafael Aquini <aquini@redhat.com>
Cc: bunk@kernel.org, jeffm@suse.com, tytso@mit.edu, keescook@chromium.org, jeyu@suse.de, corbet@lwn.net, tiwai@suse.de, torvalds@linux-foundation.org, jikos@kernel.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AnDavis@suse.com, mcgrof@kernel.org, cai@lca.pw, gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, rpalethorpe@suse.de, akpm@linux-foundation.org, labbott@redhat.com, dyoung@redhat.com

On 5/9/20 7:59 PM, Baoquan He wrote:
> Read admin-guide/tainted-kernels.rst, but still do not get what 'G' means.

I interpret 'G' as GPL (strictly it means that no proprietary module has
been loaded).  But I don't see why TAINT_PROPRIETARY_MODULE is the only
taint flag that has a non-blank c_false character.  It could just be blank
also AFAICT.  Then the 'G' would not be there to confuse us.  :)

-- 
~Randy


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
