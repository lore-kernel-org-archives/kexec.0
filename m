Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1431012726.12082.28.camel@infradead.org>
Subject: Re: [PATCH RFC 0/3] arm64: disable/enable d-cache support for
From: Geoff Levand <geoff@infradead.org>
Date: Thu, 07 May 2015 08:32:06 -0700
In-Reply-To: <554AEFF7.5070300@redhat.com>
References: <cover.1430742915.git.panand@redhat.com>
 <1430931959.12082.12.camel@infradead.org> <554A5151.7020706@redhat.com>
 <554AE924.4040208@linaro.org> <554AEFF7.5070300@redhat.com>
Mime-Version: 1.0
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
To: Pratyush Anand <panand@redhat.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org

On Thu, 2015-05-07 at 10:24 +0530, Pratyush Anand wrote:

> @Geoff: Do you see any specific side effect for enabling D-cache in 
> purgatory, other than the fact that it increases size of purgatory? May 
> be we can keep an user option to select/not select d-cache enabling.

The checks in purgatory are for kdump, which won't be a regularly used
feature.  I don't want to add the complexity to save one minute for
someone who will likely spend several hours working on a problem that
triggered a kdump. 

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
