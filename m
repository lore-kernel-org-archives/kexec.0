Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDvqa-0007xy-VQ
 for kexec@lists.infradead.org; Fri, 08 Mar 2013 11:52:29 +0000
Message-ID: <5139D0F5.1000206@citrix.com>
Date: Fri, 8 Mar 2013 11:52:21 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/8] kexec: add public interface for improved load/unload
 sub-ops
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
 <1361468894-18655-4-git-send-email-david.vrabel@citrix.com>
 <20130308105004.GD10740@debian70-amd64.local.net-space.pl>
In-Reply-To: <20130308105004.GD10740@debian70-amd64.local.net-space.pl>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On 08/03/13 10:50, Daniel Kiper wrote:
> On Thu, Feb 21, 2013 at 05:48:09PM +0000, David Vrabel wrote:
>> From: David Vrabel <david.vrabel@citrix.com>
>>
>> Add replacement KEXEC_CMD_load and KEXEC_CMD_unload sub-ops to the
>> kexec hypercall.  These new sub-ops allow a priviledged guest to
>> provide the image data to be loaded into Xen memory or the crash
>> region instead of guests loading the image data themselves and
>> providing the relocation code and metadata.
>>
>> The old interface is provided to guests requesting an interface
>> version prior to 4.3.
>>
>> Signed-off: David Vrabel <david.vrabel@citrix.com>
> 
> [...]
> 
>> diff --git a/xen/include/public/kexec.h b/xen/include/public/kexec.h
>> index 61a8d7d..5259446 100644
>> --- a/xen/include/public/kexec.h
>> +++ b/xen/include/public/kexec.h
>> @@ -116,12 +116,12 @@ typedef struct xen_kexec_exec {
>>   * type  == KEXEC_TYPE_DEFAULT or KEXEC_TYPE_CRASH [in]
>>   * image == relocation information for kexec (ignored for unload) [in]
>>   */
>> -#define KEXEC_CMD_kexec_load            1
>> -#define KEXEC_CMD_kexec_unload          2
>> -typedef struct xen_kexec_load {
>> +#define KEXEC_CMD_kexec_load_v1         1 /* obsolete since 0x00040300 */
>> +#define KEXEC_CMD_kexec_unload_v1       2 /* obsolete since 0x00040300 */
>> +typedef struct xen_kexec_load_v1 {
>>      int type;
>>      xen_kexec_image_t image;
>> -} xen_kexec_load_t;
>> +} xen_kexec_load_v1_t;
> 
> I think that this is not good idea to redefine meaning of constants,
> types, structures, etc. IMO it is comparable to redefining meaning
> of words in any laguage (e.g. English). It will be very confusing
> and may easily lead to stupid bugs. I think that old interface should
> stay as is (with its bad behavior). New interface should be introduced
> with "_v2" suffix, e.g. KEXEC_CMD_kexec_load_v2, ...
> This would not confuse our descendants.

This is something that was requested (by Ian C) as the Xen way of doing it.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
